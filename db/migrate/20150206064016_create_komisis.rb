class CreateKomisis < ActiveRecord::Migration
  def change
    create_table :komisis do |t|
      t.string  :nama
    end
  end
end
