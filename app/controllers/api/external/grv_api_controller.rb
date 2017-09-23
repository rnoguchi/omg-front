require "mechanize"

class Api::External::GrvApiController < ApplicationController
  def index
    begin
      apiKey = ""
      File.open(Settings.paths[:grv_auth_path]) do |file|
        apiKey = file.read
      end
      agent = Mechanize.new
      agent.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"

      # 食べ店舗取得
      gs_store_infos = GsStoreInfo.where(gs_cd: Constants::TBL)

      if gs_store_infos.blank?
        render json: {"msg" => "TBL店舗0件"}, status:200
      end

      # 食べ店毎にAPI呼び出し
      result = nil;
      for info in gs_store_infos do
        url = "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=" + apiKey + "&format=json&name=" + info.store_name
        agent.get(url) do |json|
          result = JSON.parse(json.content.toutf8)
        end

        sleep(1)

        logger.info url

        error = result["error"]
        unless error.blank?
          logger.error error
          next
        end

        # 既存データ取得
        id = ""
        for key, value in result["rest"] do
          if key == "id"
            id = value.to_s
          end
        end

        isUpdate = true
        gs_store = GsStoreInfo.where("store_id = :store_id and gs_cd = :gs_cd",store_id: id, gs_cd: Constants::GRV)
        if gs_store.blank?
          gs_store = GsStoreInfo.new
          isUpdate = false
        else
          gs_store = gs_store[0]
        end

        gs_store.store_id = id

        for key, value in result["rest"] do
          if key == "name"
            gs_store.store_name = value.to_s
          elsif key == "image_url"
            gs_store.store_img_url = value["shop_image1"]
          elsif key == "holiday"
            gs_store.holiday = value
          elsif key == "opentime"
            gs_store.business_hours = value
          elsif key == "url"
            gs_store.pc_site_url = value
          elsif key == "url_mobile"
            gs_store.mobile_site_url = value
          elsif key == "lunch"
            gs_store.average_lunch_price = value
          elsif key == "budget"
            gs_store.average_dinner_price = value
          elsif key == "category"
            gs_store.genre = value
          end
        end

        gs_store.gs_cd = Constants::GRV

        if isUpdate
          gs_store.upd_date = Time.zone.now
          gs_store.upd_apl = self.class.to_s
        else
          gs_store.store_group_id = info.store_group_id
          gs_store.reg_date = Time.zone.now
          gs_store.reg_apl = self.class.to_s
          gs_store.version = 1
        end

        # 更新
        gs_store.save
      end
      render json: {"msg" => "正常終了"}, status:200
    rescue => e
      outputLog(e)
      render json: {"msg" => "異常終了"}, status:500
    end
  end
end