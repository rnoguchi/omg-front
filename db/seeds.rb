# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#GsStoreInfo.create(:store_id => '11111', :store_name => '店舗名１',:store_img_url => 'http://www.material-ui.com/images/grid-list/vegetables-790022_640.jpg',:business_hours => '20:00～22:00',:holiday => '月曜日', :pc_site_url => 'http://localhost:3000/', :evaluation_score => 3.5, :store_group_id => 's00001')
#GsStoreInfo.create(:store_id => '22222', :store_name => '店舗名２',:store_img_url => 'http://www.material-ui.com/images/grid-list/burger-827309_640.jpg',:business_hours => '15:00～23:00',:holiday => '日曜日', :pc_site_url => 'http://localhost:3000/', :evaluation_score => 4.5, :store_group_id => 's00002')
#GsStoreGroup.create(:store_group_id => 's00001', :store_name => '店舗名１')
#GsStoreGroup.create(:store_group_id => 's00002', :store_name => '店舗名２')


GsStoreInfo.create(:store_id => 'aaaaa', :store_name => '店舗名１',:store_img_url => 'http://www.material-ui.com/images/grid-list/vegetables-790022_640.jpg',:business_hours => '20:00～22:00',:holiday => '月曜日', :pc_site_url => 'http://localhost:3000/', :evaluation_score => 1.5, :store_group_id => 's00001', :gs_cd => 'GRV')
GsStoreInfo.create(:store_id => 'bbbbb', :store_name => '店舗名２',:store_img_url => 'http://www.material-ui.com/images/grid-list/burger-827309_640.jpg',:business_hours => '15:00～23:00',:holiday => '日曜日', :pc_site_url => 'http://localhost:3000/', :evaluation_score => 2.5, :store_group_id => 's00002', :gs_cd => 'GRV')