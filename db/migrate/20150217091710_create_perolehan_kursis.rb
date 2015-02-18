class CreatePerolehanKursis < ActiveRecord::Migration
  def change
    create_table :perolehan_kursis do |t|
      t.string  :id_partai
      t.string  :jumlah
      t.string  :daerah_pemilihan_id
    end
  end
end
