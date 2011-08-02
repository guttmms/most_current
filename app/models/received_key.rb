class ReceivedKey < ActiveRecord::Base
  belongs_to :received_table
  belongs_to :key
  has_many :friend_min_hops
  
  def update_h_max(incoming_h_max)
    if max_hops < incoming_h_max
      self.update(:max_hops => incoming_h_max)
      self.save
    end
  end
end
