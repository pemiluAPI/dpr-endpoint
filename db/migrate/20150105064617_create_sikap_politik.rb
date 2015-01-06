class CreateSikapPolitik < ActiveRecord::Migration
  def change
    create_table :sikap_politiks do |t|
      t.string :id_calon
      t.string :ringkasan
    end
  end
end
