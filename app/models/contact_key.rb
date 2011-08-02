class ContactKey < ActiveRecord::Base
  belongs_to :contact
  belongs_to :key
end
