class AddStoreGroupIdToGsStoreInfos < ActiveRecord::Migration
  def change
    add_column :gs_store_infos, :store_group_id, :varchar
  end
end
