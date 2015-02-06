class Komisi < ActiveRecord::Base
  self.primary_key = 'id'
  has_many :anggota_dprs, foreign_key: :komisi_id
end
