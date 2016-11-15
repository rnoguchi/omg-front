class CreateGsStoreInfos < ActiveRecord::Migration
  def change
    create_table :gs_store_infos do |t|
      t.string :store_id
      t.string :gs_cd
      t.string :store_name
      t.string :store_img_url
      t.string :business_hours
      t.string :holiday
      t.string :pc_site_url
      t.string :mobile_site_url
      t.float :evaluation_score
      t.string :genre
      t.string :average_dinner_price
      t.string :average_lunch_price
      t.boolean :visit_already_flg
      t.timestamp :upd_date
      t.string :upd_apl
      t.timestamp :reg_date
      t.string :reg_apl
      t.integer :version

      t.timestamps null: false
    end
  end
end
