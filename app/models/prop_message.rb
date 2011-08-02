class PropMessage < ActiveRecord::Base
  has_many :message_users, :dependent => :destroy
  has_many :users, :through => :message_users
  belongs_to :forward_key, :dependent => :destroy
  
  def non_inclusive?(propmessage2)
    if (propmessage2.hops_remaining - hops_remaining) >= 0
      return true
    end
    if (propmessage2.hops_covered - hops_covered) < 0
      return true
    end
    return false
  end
end
