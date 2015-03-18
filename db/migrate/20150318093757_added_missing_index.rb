class AddedMissingIndex < ActiveRecord::Migration
  def change
    add_index :akd_members, :akd_id
    add_index :anggota_dprs, :komisi_id
    add_index :perolehan_kursis, :daerah_pemilihan_id
  end
end
