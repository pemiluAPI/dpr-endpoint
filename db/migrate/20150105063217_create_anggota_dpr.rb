class CreateAnggotaDpr < ActiveRecord::Migration
  def change
    create_table :anggota_dprs do |t|
      t.string  :lembaga
      t.string  :id_provinsi
      t.string  :id_dapil
      t.string  :id_partai
      t.integer :urutan
      t.string  :nama
      t.string  :jenis_kelamin
      t.string  :agama
      t.string  :tempat_lahir
      t.string  :tanggal_lahir
      t.string  :foto_url
      t.integer :tahun
      t.string  :status_perkawinan
      t.string  :nama_pasangan
      t.string  :jumlah_anak
      t.string  :kelurahan_tinggal
      t.string  :kecamatan_tinggal
      t.string  :kab_kota_tinggal
      t.string  :provinsi_tinggal
      t.integer :suara_sah
      t.integer :peringkat_suara_sah_calon
      t.string  :terpilih
    end
  end
end
