class Api::V1::GrmlistController < ApplicationController
  def index
    begin
      gs_store_infos = GsStoreInfo.where(gs_cd: Constants::TBL)
      render json: gs_store_infos
    rescue => e
      outputLog(e)
      render json: {}, status:500
    end
  end

  def show
    begin
      gs_store_detail_infos = GsStoreInfo.where("store_group_id = ?", params[:id])
      count = 0
      for store_info in gs_store_detail_infos do
        gs_store_detail_infos[count].gs_name = Constants::GS_NAME[store_info.gs_cd]
        count =+ 1
      end
      render :layout => false, :json => gs_store_detail_infos.to_json(methods: :gs_name)
    rescue => e
      outputLog(e)
      render json: {"msg" => "異常終了"}, status:500
    end
  end
end