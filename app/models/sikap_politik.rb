class SikapPolitik < ActiveRecord::Base
    belongs_to :anggota_dpr, foreign_key: :id_calon
end
