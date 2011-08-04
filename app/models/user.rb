class User < ActiveRecord::Base
  has_one :qid_table, :dependent => :destroy
  has_many :message_users
  has_many :prop_messages, :through => :message_users
  has_one :received_table, :dependent => :destroy
  has_one :forward_table, :dependent => :destroy
  has_many :linked_contacts, :dependent => :destroy
  has_many :keys, :dependent => :destroy

  has_many :authentications
  has_one :profile, :dependent => :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
  
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :prepare_password
  after_create :create_profile

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  @@results 
  
  def find_target(keyword)
    
    targets = linked_contacts.includes(:contact_keys).where("contact_keys.key_id" => keyword.id)
    
    #debugger
    return targets
  end
  
  def start_query(search)
    search.downcase!
    query_keys =  search.split(' ')
    qid = (1..8).collect { (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }.join
    q = Qid.new(:qid => qid)
    q.save
    hops_done = 0
    hops_left = 10
    origin_id = self.id
    query_message = [q, query_keys, hops_done, hops_left, origin_id]
    
    friendships.map {|obj| obj.user }
    
    friendships.map(&:friend_id).each do |friend_id|
      friend = User.find(friend_id)
      #received_keys_query_keys = []
      relevant_keys =  Key.joins(:received_keys => :friend_min_hops).where("received_keys.key_id" => received_table.received_keys.map(&:key_id))
      
      query_keys.each do |query_key| 
        #received_keys_query_keys = received_keys_query_keys + received_table.received_keys.joins(:key).where(:conditions => ['keyword LIKE ?', "%#{query_keys}%"]) #received_table.received_keys.includes(:keys).where(:received_key_id => {})
        relevant_keys = relevant_keys.where('keyword LIKE ?', "%#{query_key}%")
      end
      friend_forwarded_key = relevant_keys.where("friend_min_hops.friend_id" => friend_id)
      @@results = []
      
      if !friend_forwarded_key.empty?
        friend.query_process(query_message, self.id)
      end
      
      return @@results
      
    end  
  end
  def success(targets, oid, chain, parent_id)
    
      if self.id == oid
        
        result = [targets, chain]
        
        @@results << result
        
      else
        chain << self
        parent = User.find(parent_id)
        parent.success(targets, oid, chain, @parent_id)
       end 
    
  end
  def query_process(message, parent_id)
    @parent_id = parent_id
    qid = message[0]
    qk = message[1]
    hd = message[2]
    hl = message[3]
    oid = message[4]
    
    if !qid_table.qid_table_qids.where(:qid_id => qid.id).nil?
      q = qid_table.qid_table_qids.build(:qid_id => qid.id)
      similar_keys = []
      qk.each do |query_key|
        similar_keys = similar_keys + keys.where('keyword LIKE ?', "%#{query_key}%")
        if !similar_keys.empty?
          targets = []
          
          similar_keys.each do |k|
            targets = targets + find_target(k)
            chain = []
            success(targets, oid, [], parent_id)
          end
        end
      end
    end
    
    if hl > 0
      friendships.each do |friend|
        if friend.id != parent_id && friend.id != oid
          received_keys_query_keys = []
          query_keys.each do |query_key|
            received_keys_query_keys = received_keys_query_keys + received_table.received_keys.find(:all, :conditions => ['keyword LIKE ?', "%#{query_key}%"])
          end
          friend_forwarded_key = received_keys_query_keys.friend_min_hops.where(:user_id => friend.id)
            if !friend_forwarded_key.empty?
              query_message = [qid, qk, hd + 1, hl -1, oid]
              friend.query_process(query_message, self.id)
            end
        end
      end
      
    end
    
  end
   
  def prop_process(keyword, message, parent_id)
    key_in_forward_table = forward_table.forward_keys.where(:key_id => keyword.id)[0]
    key_in_forward_table.nil? ? keys_messages = [] : keys_messages = key_in_forward_table.prop_messages #:  unless key_in_forward_table.nil?
    
    key_in_received_table = received_table.received_keys.where(:key_id => keyword.id)[0]
    
    pid = message[0]
    hr = message[1]
    hc = message[2]
    oid = message[3]
    
     if !key_in_forward_table.nil? && !keys_messages.where(:pid => pid).empty?
      debugger
      stored_message = keys_messages.where(:pid => pid)[0]
        if stored_message.non_inclusive?(message)
        stored_message.update(:pid => pid, :hops_remaining => hr, :hops_covered => hc, :origin_id => oid)
        #stored_message.save
        #update search info
        received_key = forward_table.received_keys.where(:key_id => keyword.id)[0]
        received_key.update_h_max(hc)
        friend_min_hops = received_key.friend_min_hops.where(:friend_id => parent_id)[0]
        friend_min_hops.update_search_info(hc)
        #
        
        friendlist = friendships
        friendlist.each do |friend|
          if !friend.nil? && friend.id != parent_id && friend.id != oid
            if hr > 1
              incremented_message = [pid, hr -1, hc +1, oid]
              message_user = stored_message.message_users.build(:user_id => friend.id)
              message_user.save
              friend.prop_process(keyword, incremented_message, self.id)
            end
          end
        end 
     end
      
    elsif !key_in_forward_table.nil? && keys_messages.where(:pid => pid).empty?
      friendlist = friendships
      
      friendlist.each do |friend|
        if !friend.nil? && friend.id != parent_id && friend.id != oid
          
         message_users_corresponding_to_friend = key_in_forward_table.prop_messages.message_users.where(:user_id => friend.id)
        
         message_users_corresponding_to_friend.each do |message_user|
            friend_message = PropMessage.find(message_user.prop_message_id)
            inclusivity_counter = 0
            if message.non_inclusive?(friend_message)
              inclusivity_counter += 1
            end
            if inclusivity_counter == message_users_corresponding_to_friend
              prop_message = key_in_forward_table.prop_messages.build(:pid => pid, :hops_remaining => hr, :hops_covered => hc, :origin_id => oid)
              prop_message.save
              
              #update search info
              received_key = forward_table.received_keys.where(:key_id => keyword.id)[0]
              received_key.update_h_max(hc)
              friend_min_hops = received_key.friend_min_hops.where(:friend_id => parent_id)[0]
              friend_min_hops.update_search_info(hc)
              #
              
            if hr > 1
                incremented_message =  [pid, hr -1, hc +1, oid]
                #incremented_message.save
                message_user = prop_message.mesage_users.build(:user_id => friend.id)
                message_user.save
                friend.prop_process(keyword, incremented_message, self.id)
              end
            end
          end
          
        end
        
      end
      
   else
      forward_key = forward_table.forward_keys.build(:key_id => keyword.id)
      forward_key.save
      prop_message = forward_key.prop_messages.build(:pid => pid, :hops_remaining => hr, :hops_covered => hc, :origin_id => oid) 
      prop_message.save
      
      if key_in_received_table.nil?
        received_key = received_table.received_keys.build(:key_id => keyword.id, :max_hops => hc)
        received_key.save
        friend_min_hops = received_key.friend_min_hops.build(:friend_id => parent_id, :h_min => hc)
        friend_min_hops.save
      else
        #updating search info
        received_key = forward_table.received_keys.where(:key_id => keyword.id)[0]
        received_key.update_h_max(hc)
        friend_min_hops = received_key.friend_min_hops.where(:friend_id => parent_id)[0]
        friend_min_hops.update_search_info(hc)
      end
      
      friendlist = friendships
      friendlist.each do |friend|
        if !friend.nil? && friend.id != parent_id && friend.id != oid
          if hr > 1
            message_user = prop_message.message_users.build(:user_id => friend.id)
            message_user.save
            
            incremented_message = [pid, hr-1, hc+1, oid]#PropMessage.new(:pid => message.pid, :hops_remaining => message.hops_remaining, :hops_covered => message.hops_covered)
            #incremented_message.save
            friend.prop_process(keyword, incremented_message, self.id)
          end
        end
        
      end
      
    end
  end

  def build_adjacency(a)
    friendship = self.friendships.build(:friend_id => a)
    friendship.save
    
  end
  def build_connections(connectionsArray)
    connectionsArray["values"].each do |connect|
      unless connect["id"] == "private"
     contact = self.linked_contacts.build(
                        :user_id => self.id, 
                        :headline => connect["headline"], 
                        :uid => connect["id"],
                        :last_name => connect['lastName'],
                        :picture_url => connect['pictureUrl'],
                        :location => connect['location']['name'],
                        :industry => connect['industry'],
                        :first_name => connect['firstName']
                        )
     contact.save
     add_keyword(contact)
      end
    end 
  end  
  
  def add_keyword(contact)
    
    headline = contact.headline
    location = contact.location
    industry = contact.industry
    keys = [headline, location, industry]
    keys.each do |key| #for key in keys
      existing_key = self.keys.where(:keyword => key)[0]
      if existing_key.nil? 
        key_instance = self.keys.build(
                             :keyword => key
                             )
         key_instance.save
         contact_key = key_instance.contact_keys.build(:linked_contact_id => contact.id)
         contact_key.save
      else
        key_instance = existing_key
        contact_key = key_instance.contact_keys.build(:linked_contact_id => contact.id)
        contact_key.save 
      end
    end
  end
  
  def apply_omniauth(omniauth)
    @authentication = self.authentications.build(
                            :provider => omniauth['provider'],
                            :uid => omniauth['uid'],
                            :token => omniauth['credentials']['token'],
                            :secret => omniauth['credentials']['secret']
                            )
    @authentication.save
  end
  def password_required?
    authentications.empty? || !password.blank?
  end
  def create_profile
   profile =  Profile.new(:user_id => self.id)
   profile.save
   forward_table = ForwardTable.new(:user_id => self.id) #ForwardTable.new(:user_id => self.id)
   forward_table.save
   received_table = ReceivedTable.new(:user_id => self.id)
   received_table.save
   qid_table = QidTable.new(:user_id => self.id)
   qid_table.save
  end
  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end
