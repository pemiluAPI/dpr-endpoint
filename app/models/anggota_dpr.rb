class AnggotaDpr < ActiveRecord::Base
  self.primary_key = 'id'
  belongs_to :province, -> { select('id, nama') }, foreign_key: :id_provinsi
  belongs_to :electoral_district, -> { select('id, nama') }, foreign_key: :id_dapil
  belongs_to :party, -> { select('id, nama') }, foreign_key: :id_partai
  belongs_to :komisi, -> { select('id, nama') }, foreign_key: :komisi_id
  has_many :sikap_politiks,  -> { select('id, sikap, program_kerja') }, foreign_key: :id_calon
  has_many :riwayat_organisasi_dprs,  -> { select('id, id_calon, ringkasan') }, foreign_key: :id_calon
  has_many :riwayat_pekerjaan_dprs,  -> { select('id, ringkasan') }, foreign_key: :id_calon
  has_many :riwayat_pendidikan_dprs,  -> { select('id, ringkasan') }, foreign_key: :id_calon
  has_many :akd_members, -> { select('id, anggota_id, jabatan, akd_id, institute') }, foreign_key: :anggota_id
end
