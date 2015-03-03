class CreateAkds < ActiveRecord::Migration
  def change
    create_table :akds do |t|
      t.string :nama
      t.text    :tugas
    end
  end
end
