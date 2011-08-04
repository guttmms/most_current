class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  
  after_save :start_prop
  
  def start_prop
    user = User.find(self.user_id)
    friend = User.find(self.friend_id)
    keys = user.keys
    
    forward_table = user.forward_table
    forward_keys = forward_table.forward_keys
    
    keys.each do |key|
      contact_keys = key.contact_keys
      contact_keys.each do |contact_key|
        pid = LinkedContact.find(contact_key.linked_contact_id).uid
        hr = 10
        hc = 0
        oid = user.id
        message = [pid, hr, hc, oid]#PropMessage.new(:pid => pid, :hops_remaining => hr, :hops_covered => hc)]
        #message.save
        unless ((friend.authentications.where(:provider => 'linked_in')[0].uid) == pid) || !friend.linked_contacts.where(:uid => pid).empty? 
          logger.debug "!!!!!!!!!!!!!!!!!forward message to #{friend.username} unless #{pid} = #{friend.authentications.where(:provider => 'linked_in')[0].uid} or  #{friend.username} doesn't have this linked contact is  false => (#{friend.linked_contacts.where(:uid => pid).empty?}) "
          logger.debug "!!!!!!!!!!!!!!!!!!!!!!!#{key.keyword}"
          
          
          friend.prop_process(key, message, user.id)
        end
        
      end
      
      
    end
    forward_keys.each do |forward_key|
      key = Key.find(forward_key.key_id)
      prop_messages = forward_key.prop_messages
      prop_messages.each do |prop_message|
        message =[prop_message.pid, prop_message.hops_remaining, prop_message.hops_covered, prop_message.origin_id]
        if friend.id != prop_message.origin_id
        friend.prop_process(key, message, user.id)
        end
      end  
    end
  end
  
end
