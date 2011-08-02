class ReceivedTable < ActiveRecord::Base
  belongs_to :user
  has_many :received_keys

end
