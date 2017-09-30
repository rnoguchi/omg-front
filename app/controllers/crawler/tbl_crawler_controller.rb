require "mechanize"
require "open-uri"
require "nokogiri"
require "logger"
require "securerandom"

class Crawler::TblCrawlerController < ApplicationController
  def index
    begin
      agent = Mechanize.new
      agent.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
      login_url = "https://account.tabelog.com/kakaku_com/new"
      logger.debug "--------- クローラー ログイン開始"
      agent.get(login_url) do |login_page|
        response = login_page.form_with(:action => "/kakaku_com") do |login_form|
          File.open(Settings.paths[:tbl_auth_path]) do |file|
            auth = file.read.split(",")
            login_form.mail_address = auth[0]
            login_form.password = auth[1]
          end
        end.submit
      end
      logger.debug "--------- クローラー ログイン終了"

      mypage_url = "https://tabelog.com/rvwr/002830288/rvwlst/0/0/?smp=0"
      agent.get(mypage_url) do |mypage|
        mypage_html = mypage.content.toutf8
        mypage_contents = Nokogiri::HTML(mypage_html, nil, "utf-8")
        isFirst = true
        for paging in mypage_contents.css("li.c-pagination__item > a") do
          logger.debug "--------- クローラー うううう"
          if isFirst
            url = "https://tabelog.com/rvwr/002830288/rvwlst/0/0/?smp=0";
            isFirst = false
          else
            url = paging[:href]
          end
          detail(url, agent)
          sleep(1)
        end
      end
      render json: {"msg" => "正常終了"}, status:200
    rescue => e
      outputLog(e)
      render json: {"msg" => "異常終了"}, status:500
    end
  end

  def detail(url, agent)
    agent.get(url) do |mypage|

      logger.debug "--------- クローラー開始 URL : " + url.to_s
      mypage_html = mypage.content.toutf8
      mypage_contents = Nokogiri::HTML(mypage_html, nil, "utf-8")

      mypage_contents.css("div.rvw-item").each do |store|
      # URL
      anchor = store.xpath(".//a[@class='simple-rvw__rst-name-target']")
      if anchor.size > 0 then
        pc_site_url = anchor[0][:href]

        # 店舗ID
        store_id = pc_site_url[40, 8]
      else
        logger.debug "店舗URLが見つからないためスキップ anchor:" + anchor.to_s
        next
      end

      # 登録済みデータ取得
      isUpdate = true
      gs_store = GsStoreInfo.where("store_id = :store_id and gs_cd = :gs_cd",store_id: store_id, gs_cd: Constants::TBL)
      if gs_store.blank?
        gs_store = GsStoreInfo.new
        isUpdate = false
      else
        gs_store = gs_store[0]
      end

      gs_store.pc_site_url = pc_site_url
      gs_store.store_id = store_id

      # 店舗名
      gs_store.store_name = store.css("a.simple-rvw__rst-name-target > h3").text

      gs_store.gs_cd = Constants::TBL
      # 画像
      store_img = store.css("p.simple-rvw__rst-img > img")
      if store_img.size > 0 then
        gs_store.store_img_url = store_img[0][:src].to_s
      elsif
        gs_store.store_img_url = "http://1.bp.blogspot.com/-RS0iX_-6XdA/V5aoqYSbQBI/AAAAAAAA8yc/tHmfWYsF8eMyYeM-iZqjnpIfCFDwK1j4QCLcB/s800/syokuji_okazu_noseru.png";
      end
      # 休日
      holiday = store.xpath(".//dt[@class='simple-rvw__holiday-subject']")
      if holiday.size > 0 then
        gs_store.holiday = holiday[0].text
      end
      # 点数
      score = store.xpath(".//b[@class='tb-rating__val']")
      if score.size > 0 then
        gs_store.evaluation_score = score[0].text
      end
      # ジャンル
      genre = store.xpath(".//p[@class='simple-rvw__area-catg']")
      if genre.size > 0 then
        gs_store.genre = genre[0].text
      end
      # 昼の平均価格
      lunch_price = store.xpath(".//span[contains(@class, 'tb-rating__time--lunch')]")
      if lunch_price.size > 0 then
        gs_store.average_lunch_price = lunch_price[0].next_sibling.text
      end
      # 夜の平均価格
      dinner_price = store.xpath(".//span[contains(@class, 'tb-rating__time--dinner')]")
      if dinner_price.size > 0 then
        gs_store.average_dinner_price = dinner_price[0].next_sibling.text
      end
      # いった/いきたい
      visit_already_flg = "0"
      visit_already = store.xpath(".//span[@class='c-btn-bkm__log-count-text']")
      if visit_already.size > 0 && visit_already[0].text == "行った" then
        visit_already_flg = "1"
      end
      gs_store.visit_already_flg = visit_already_flg

      if isUpdate
        gs_store.upd_date = Time.zone.now
        gs_store.upd_apl = self.class.to_s
      else
        other_store = GsStoreInfo.where("store_name = :store_name",store_name: gs_store.store_name)
        if other_store.blank?
          gs_store.store_group_id = "S" + SecureRandom.hex(12)
        else
          gs_store.store_group_id = other_store.store_group_id
        end

        gs_store.reg_date = Time.zone.now
        gs_store.reg_apl = self.class.to_s
        gs_store.version = 1
      end
      gs_store.save
      end
      logger.debug "--------- クローラー終了 URL : " + url.to_s
    end
  end
end
