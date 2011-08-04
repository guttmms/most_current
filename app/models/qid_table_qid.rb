class QidTableQid < ActiveRecord::Base
  belongs_to :qid
  belongs_to :qid_table
end
