#require 'linkedin'
#require 'uri'
#require 'net/http'
require 'json' 
class AuthenticationsController < ApplicationController
  
  def index
    @authentications = current_user.authentications.all if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      user = authentication.user
      session[:user_id] = user.id
      redirect_to_target_or_default user_path(user), :notice => "Logged in successfully."
      
    elsif current_user
      #authorization being created for user who is currently authenticating
      @auth = current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'], :secret => omniauth['credentials']['secret'])
     
      #if :provider == 'linked_in'
      if omniauth['provider'] == 'linked_in'
        
       response = connections
       @responseArray = JSON.parse(response)
       current_user.build_connections(@responseArray)
        
         #when a user auths for the first time, see what users connections contain that uid
          
            adjConnections = LinkedContact.where(:uid => @auth.uid)
            #if there are users who have that user as a connection, build that adjacency
            
            if !adjConnections.empty?
                
              adjConnections.each do |connection|                   #for connection in adjConnections do
               adjacent_user = User.find(connection.user_id)
                          #adjacent_user_id = adjacent_user.id
               friendship = Friendship.new(:user_id => current_user.id, :friend_id => adjacent_user.id)#current_user.friendships.build(:friend_id => adjacent_user.id) #current_user.friendships.build(:friend_id => @adjacent_user.id)
                          #friendship.user_id = current_user.id
                          #friendship.friend_id = adjacent_user.id
               friendship.save
               friend = Friendship.create(:user_id => adjacent_user.id, :friend_id => current_user.id)
               #friend.save
                 
              end

            end
        
       #render :json => response
       redirect_to user_path(current_user)
       flash[:notice] = 'Authentication successful.'
      end
      
      #flash[:notice] = 'Authentication successful.'
      #redirect_to authentications_url
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        session[:user_id] = user.id
        flash[:notice] = "Sign in Successful"
        redirect_to_target_or_default user_path(user), :notice => "Logged in successfully."
      else
        session[:omniauth] = omniauth.except('extra')
        #redirect_to new_user_path
      end
    end
  end
  def connections
    #Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
    
    def prepare_access_token(oauth_token, oauth_token_secret)
      consumer = OAuth::Consumer.new("2mSbq_57emLImly168kg-HXH_P-9_ayy314TZAOmWXRRE5YnWt4dij0UpSnqi7oS", "DVpkMPzA3uloBdMCFewu2oZcB00nHP1Rf6ucgUwtQ8ohHDERpz6foJil_2OjZU73",
          { :site => "https://api.linkedin.com"
          })
          # now create the access token object from passed values
          token_hash = { :oauth_token => oauth_token,
                         :oauth_token_secret => oauth_token_secret
                         }
          access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
          return access_token
      end
      
      #auth = current_user.authentications.find(:first, :conditions => {:provider => 'linked_in'})
      
      #Exchange out oauth_token and oauth_token_secret for the AccessToken instance.
      access_token = prepare_access_token(@auth['token'], @auth['secret'])
      
      #use the access token as an agent to get the timeline
      #response = access_token.request(:get, "/v1/people/~/connections")
       json_txt = access_token.get("/v1/people/~/connections", 'x-li-format' => 'json')
       response = json_txt #ActiveSupport::JSON.decode(json_txt)
      return response.body
      
    end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end
