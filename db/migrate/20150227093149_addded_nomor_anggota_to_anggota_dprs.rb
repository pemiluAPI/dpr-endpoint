class AdddedNomorAnggotaToAnggotaDprs < ActiveRecord::Migration
  def change
    add_column :anggota_dprs, :nomor_anggota, :string
  end
end
