class ContactKey < ActiveRecord::Base
  belongs_to :linked_contact 
  belongs_to :key
end
