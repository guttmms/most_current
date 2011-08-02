class ForwardKey < ActiveRecord::Base
  belongs_to :forward_table
  belongs_to :key
  has_many :prop_messages
end
