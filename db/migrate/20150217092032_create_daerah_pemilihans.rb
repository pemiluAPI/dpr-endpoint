class CreateDaerahPemilihans < ActiveRecord::Migration
  def change
    create_table :daerah_pemilihans do |t|
      t.string  :nama
      t.string  :alokasi_kursi
    end
  end
end
