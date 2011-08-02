class FriendMinHop < ActiveRecord::Base
  belongs_to :user
  belongs_to :received_key
  
  def update_search_info(incoming_min_hops)
    if incoming_min_hops < h_min
      self.update(:h_min => incoming_min_hops)
    end
  end
end
