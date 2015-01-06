class ChangeDataTypeOnElectoralDistrics < ActiveRecord::Migration
  def change
    change_table :electoral_districts do |t|
      t.change :id, :string
    end
  end
end
