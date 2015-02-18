class Party < ActiveRecord::Base
  self.primary_key = 'id'
  has_many :anggota_dprs, foreign_key: :id_partai
  has_many :perolehan_kursis, foreign_key: :id_partai
end
