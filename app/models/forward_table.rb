class ForwardTable < ActiveRecord::Base
  belongs_to :user
  has_many :forward_keys, :dependent => :destroy
  has_many :keys, :through => :forward_keys
end
