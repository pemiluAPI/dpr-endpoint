class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :nama
      t.string :nama_lengkap
      t.string :url_situs
      t.string :url_facebook
      t.string :url_twitter
      t.string :url_logo_mini
      t.string :url_logo_small
      t.string :url_logo_medium
    end
  end
end
