class AkdMember < ActiveRecord::Base
  self.primary_key = 'id'
  belongs_to :anggota_dpr, foreign_key: :anggota_id
end
