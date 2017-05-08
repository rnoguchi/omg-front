class Api::V1::GrmlistController < ApplicationController
  def index
    begin
      gs_store_infos = GsStoreInfo.where(gs_cd: 'TBL')
      render json: gs_store_infos
    rescue => e
      render json: {}, status:200
    end
  end

  def show
    begin
      gs_store_detail_infos = GsStoreInfo.where("store_group_id = ?", params[:id])
      render json: gs_store_detail_infos
    rescue => e
      render json: {}, status:200
    end
  end
end
