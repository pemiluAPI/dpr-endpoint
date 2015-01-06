module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :anggota do
      desc "Return all Anggota DPR 2014"
      get do
        anggota_dpr = Array.new

        # Prepare conditions based on params
        valid_params = {
          jenis_kelamin: 'jenis_kelamin',
          dapil: 'id_dapil',
          partai: 'id_partai',
          provinsi: 'id_provinsi',
          tahun: 'tahun'
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        # Set default limit
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 1000 : params[:limit]

        search = ["nama LIKE ? and agama LIKE ?", "%#{params[:nama]}%", "%#{params[:agama]}%"]

        AnggotaDpr.includes(:province, :electoral_district, :party)
          .where(conditions)
          .where(search)
          .limit(limit)
          .offset(params[:offset])
          .each do |anggota|
            anggota_dpr << {
              id: anggota.id,
              tahun: anggota.tahun,
              lembaga: anggota.lembaga,
              nama: anggota.nama,
              jenis_kelamin: anggota.jenis_kelamin,
              agama: anggota.agama,
              tempat_lahir: anggota.tempat_lahir,
              tanggal_lahir: anggota.tanggal_lahir,
              status_perkawinan: anggota.status_perkawinan,
              nama_pasangan: anggota.nama_pasangan,
              jumlah_anak: anggota.jumlah_anak,
              kelurahan_tinggal: anggota.kelurahan_tinggal,
              kecamatan_tinggal: anggota.kecamatan_tinggal,
              kab_kota_tinggal: anggota.kab_kota_tinggal,
              provinsi_tinggal: anggota.provinsi_tinggal,
              provinsi: anggota.province,
              dapil: anggota.electoral_district,
              partai: anggota.party,
              urutan: anggota.urutan,
              foto_url: anggota.foto_url,
              suara_sah: anggota.suara_sah,
              peringkat_suara_sah_calon: anggota.peringkat_suara_sah_calon,
              terpilih: anggota.terpilih
            }
        end

        {
          results: {
            count: anggota_dpr.count,
            total: AnggotaDpr.where(conditions).where(search).count,
            anggota: anggota_dpr
          }
        }
      end

      desc "Return a Anggota DPR 2014"
      params do
        requires :id, type: String, desc: "Anggota DPR ID."
      end
      route_param :id do
        get do
            anggota = AnggotaDpr.find_by(id: params[:id])

            {
              results: {
                count: 1,
                total: 1,
                anggota: [{
                  id: anggota.id,
                  tahun: anggota.tahun,
                  lembaga: anggota.lembaga,
                  nama: anggota.nama,
                  jenis_kelamin: anggota.jenis_kelamin,
                  agama: anggota.agama,
                  tempat_lahir: anggota.tempat_lahir,
                  tanggal_lahir: anggota.tanggal_lahir,
                  status_perkawinan: anggota.status_perkawinan,
                  nama_pasangan: anggota.nama_pasangan,
                  jumlah_anak: anggota.jumlah_anak,
                  kelurahan_tinggal: anggota.kelurahan_tinggal,
                  kecamatan_tinggal: anggota.kecamatan_tinggal,
                  kab_kota_tinggal: anggota.kab_kota_tinggal,
                  provinsi_tinggal: anggota.provinsi_tinggal,
                  riwayat_pendidikan: anggota.riwayat_pendidikan_dprs,
                  riwayat_pekerjaan: anggota.riwayat_pekerjaan_dprs,
                  riwayat_organisasi: anggota.riwayat_organisasi_dprs,
                  provinsi: anggota.province,
                  dapil: anggota.electoral_district,
                  partai: anggota.party,
                  urutan: anggota.urutan,
                  foto_url: anggota.foto_url,
                  suara_sah: anggota.suara_sah,
                  peringkat_suara_sah_calon: anggota.peringkat_suara_sah_calon,
                  terpilih: anggota.terpilih
                }]
              }
            }
        end
      end
    end

  end
end