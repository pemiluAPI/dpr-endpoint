module DprHelpers
  def build_party(data_perolehan)
    perolehan_kursi = Array.new

    data_perolehan.map {|perolehan|
      perolehan_kursi << {
        id: perolehan.id,
        partai: perolehan.party,
        jumlah: perolehan.jumlah
      }
    }

    return perolehan_kursi
  end
end

module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :anggota do
      desc "Return all member of DPR"
      get do
        members = Array.new

        # Prepare conditions based on params
        valid_params = {
          jenis_kelamin: 'jenis_kelamin',
          dapil: 'id_dapil',
          partai: 'id_partai',
          provinsi: 'id_provinsi',
          tahun: 'tahun',
          komisi: 'komisi_id'
        }

        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        # Set default limit
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 1000 : params[:limit]

        search = ["nama LIKE ? and agama LIKE ?", "%#{params[:nama]}%", "%#{params[:agama]}%"]

        AnggotaDpr.includes(:province, :electoral_district, :party, :komisi)
          .where(conditions)
          .where(search)
          .limit(limit)
          .offset(params[:offset])
          .each do |member|
            members << {
              id: member.id,
              tahun: member.tahun,
              lembaga: member.lembaga,
              nama: member.nama,
              jenis_kelamin: member.jenis_kelamin,
              agama: member.agama,
              tempat_lahir: member.tempat_lahir,
              tanggal_lahir: member.tanggal_lahir,
              status_perkawinan: member.status_perkawinan,
              nama_pasangan: member.nama_pasangan,
              jumlah_anak: member.jumlah_anak,
              kelurahan_tinggal: member.kelurahan_tinggal,
              kecamatan_tinggal: member.kecamatan_tinggal,
              kab_kota_tinggal: member.kab_kota_tinggal,
              provinsi_tinggal: member.provinsi_tinggal,
              provinsi: member.province,
              dapil: member.electoral_district,
              partai: member.party,
              urutan: member.urutan,
              foto_url: member.foto_url,
              suara_sah: member.suara_sah,
              peringkat_suara_sah_calon: member.peringkat_suara_sah_calon,
              terpilih: member.terpilih,
              komisi: member.komisi
            }
        end

        {
          results: {
            count: members.count,
            total: AnggotaDpr.where(conditions).where(search).count,
            anggota: members
          }
        }
      end

      desc "Return a member of DPR"
      params do
        requires :id, type: String, desc: "Member of DPR ID."
      end
      route_param :id do
        get do
            member = AnggotaDpr.find_by(id: params[:id])

            {
              results: {
                count: 1,
                total: 1,
                anggota: [{
                  id: member.id,
                  tahun: member.tahun,
                  lembaga: member.lembaga,
                  nama: member.nama,
                  jenis_kelamin: member.jenis_kelamin,
                  agama: member.agama,
                  tempat_lahir: member.tempat_lahir,
                  tanggal_lahir: member.tanggal_lahir,
                  status_perkawinan: member.status_perkawinan,
                  nama_pasangan: member.nama_pasangan,
                  jumlah_anak: member.jumlah_anak,
                  kelurahan_tinggal: member.kelurahan_tinggal,
                  kecamatan_tinggal: member.kecamatan_tinggal,
                  kab_kota_tinggal: member.kab_kota_tinggal,
                  provinsi_tinggal: member.provinsi_tinggal,
                  riwayat_pendidikan: member.riwayat_pendidikan_dprs,
                  riwayat_pekerjaan: member.riwayat_pekerjaan_dprs,
                  riwayat_organisasi: member.riwayat_organisasi_dprs,
                  sikap_politik: member.sikap_politiks,
                  provinsi: member.province,
                  dapil: member.electoral_district,
                  partai: member.party,
                  urutan: member.urutan,
                  foto_url: member.foto_url,
                  suara_sah: member.suara_sah,
                  peringkat_suara_sah_calon: member.peringkat_suara_sah_calon,
                  terpilih: member.terpilih,
                  komisi: member.komisi
                }]
              }
            }
        end
      end
    end

    resource :komisi do
      desc "Return all Komisi DPR"
      get do
        komisi = Array.new

        valid_params = {
            komisi: 'id'
        }

        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        Komisi.where(conditions)
          .each do |data|
            komisi << {
              id: data.id,
              nama: data.nama
            }
        end

        {
          results: {
            count: komisi.count,
            komisi: komisi
          }
        }
      end

      desc "Return a Komisi"
      params do
        requires :id, type: Integer, desc: "Komisi ID."
      end
      route_param :id do
        get do
            komisi = Komisi.find_by(id: params[:id])
          {
            results: {
              count: 1,
              total: 1,
              komisi: [{
                id: komisi.id,
                nama: komisi.nama
              }]
            }
          }
        end
      end
    end

    resource :perolehan_kursi do
      helpers DprHelpers

      desc "Return all Penetapan Kursi Calon Terpilih"
      get do
        penetapan_perolehan_kursi = Array.new

        # Prepare conditions based on params
        valid_params = {
          daerah: 'id'
        }

        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        # Set default limit
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 50 : params[:limit]

        DaerahPemilihan.includes([:perolehan_kursis => :party])
          .where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |daerah|

            penetapan_perolehan_kursi << {
                id: daerah.id,
                nama: daerah.nama,
                perolehan_kursi: build_party(daerah.perolehan_kursis)
            }

        end

        {
          results: {
            count: penetapan_perolehan_kursi.count,
            total: DaerahPemilihan.where(conditions).count,
            data: penetapan_perolehan_kursi
          }
        }
      end
    end

  end
end