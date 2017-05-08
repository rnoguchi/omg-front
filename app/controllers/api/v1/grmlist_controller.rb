class Api::V1::GrmlistController < ApplicationController
  def index
    gs_store_infos = GsStoreInfo.find_by(gs_cd: 'TBL')
    render json: gs_store_infos
  end

  def show
    gs_store_infos = GsStoreInfo.find(params[:id])
    render json: gs_store_infos
  end
end
