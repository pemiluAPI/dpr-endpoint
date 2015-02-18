class PerolehanKursi < ActiveRecord::Base
  self.primary_key = 'id'
  belongs_to :daerah_pemilihan, foreign_key: :daerah_pemilihan_id
  belongs_to :party, -> { select('id, nama') }, foreign_key: :id_partai
end
