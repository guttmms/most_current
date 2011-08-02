class LinkedContact < ActiveRecord::Base
  belongs_to :user
  has_many :contact_keys
  has_many :keys, :through => :contact_keys
end
