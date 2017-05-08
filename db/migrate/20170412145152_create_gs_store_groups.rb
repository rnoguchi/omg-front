class CreateGsStoreGroups < ActiveRecord::Migration
  def change
    create_table :gs_store_groups do |t|
      t.string :store_group_id, null: false
      t.string :store_name, null: false
      t.timestamp :upd_date
      t.string :upd_apl
      t.timestamp :reg_date
      t.string :reg_apl
      t.integer :version
    end
    add_index :gs_store_groups, [:store_group_id, :store_name], :unique => true
  end
end
