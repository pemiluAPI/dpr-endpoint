class DaerahPemilihan < ActiveRecord::Base
  self.primary_key = 'id'
  has_many :perolehan_kursis, foreign_key: :daerah_pemilihan_id
end
