class MessageUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :prop_message
end
