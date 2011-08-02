class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :keys, :dependent => :destroy
end
