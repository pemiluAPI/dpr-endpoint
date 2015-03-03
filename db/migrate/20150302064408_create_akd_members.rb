class CreateAkdMembers < ActiveRecord::Migration
  def change
    create_table :akd_members do |t|
      t.string  :anggota_id
      t.string  :nomor_anggota
      t.string  :jabatan
      t.string  :akd_id
      t.string  :institute
    end
  end
end
