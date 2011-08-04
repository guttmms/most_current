class QidTable < ActiveRecord::Base
  belongs_to :user
  has_many :qid_table_qids, :dependent => :destroy
  has_many :qids, :through => :qid_table_qids
end
