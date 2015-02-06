class Province < ActiveRecord::Base
  has_many :anggota_dprs, foreign_key: :id_provinsi
  has_many :electoral_districts, foreign_key: :id_provinsi
end
