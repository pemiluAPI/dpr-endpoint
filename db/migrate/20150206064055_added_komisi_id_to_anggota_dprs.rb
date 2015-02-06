class AddedKomisiIdToAnggotaDprs < ActiveRecord::Migration
  def change
    add_column :anggota_dprs, :komisi_id, :string
  end
end
