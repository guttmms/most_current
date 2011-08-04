class Qid < ActiveRecord::Base
  has_many :qid_table_qids
  has_many :qid_tables, :through => :qid_table_qids
end
