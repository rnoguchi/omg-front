class Api::V1::GrmlistController < ApplicationController
  def index
    gs_store_infos = GsStoreInfo.all
    render json: gs_store_infos
  end
end
