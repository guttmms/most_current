class Key < ActiveRecord::Base
  belongs_to :user
  has_many :received_keys
  has_many :received_tables, :through => :received_keys
  has_many :contact_keys
  has_many :linked_contacts, :through => :contact_keys
  has_many :forward_keys
  has_many :forward_tables, :through => :forward_keys
  has_many :prop_messages
  
end
