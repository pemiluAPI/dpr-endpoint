class AddFieldToSikapPolitiks < ActiveRecord::Migration
  def change
    change_table :sikap_politiks do |t|
        t.string  :sikap
        t.string  :program_kerja
    end
  end
end
