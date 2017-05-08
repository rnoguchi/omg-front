class GsStoreInfos < ActiveRecord::Migration
  def change
    add_index :gs_store_infos, [:store_id,:gs_cd], :unique => true
  end
end
