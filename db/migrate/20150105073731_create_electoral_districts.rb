class CreateElectoralDistricts < ActiveRecord::Migration
  def change
    create_table :electoral_districts do |t|
      t.string  :nama
      t.string  :nama_lengkap
      t.string  :id_provinsi
      t.string  :nama_lembaga
      t.integer :jumlah_kursi
      t.integer :jumlah_penduduk
    end
  end
end
