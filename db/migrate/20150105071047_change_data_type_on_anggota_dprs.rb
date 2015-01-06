class ChangeDataTypeOnAnggotaDprs < ActiveRecord::Migration
  def change
    change_table :anggota_dprs do |t|
      t.change :id, :string
    end
  end
end
