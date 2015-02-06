class RemoveRingkasanOnSikapPolitiks < ActiveRecord::Migration
  def change
    remove_column :sikap_politiks, :ringkasan
  end
end
