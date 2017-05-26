class Scrapper < ApplicationJob

  def perform(id)
    search = Search.find(id)

    case search.type.name
    when 'Maison' then type = 1
    when 'Appartement' then type = 2
    when 'Terrain' then type = 3
    when 'Parking' then type = 4
    when 'Autre' then type = 5
    end

    case search.budget
    when 1..25000 then budget = 1
    when 25001..50000 then budget = 2
    when 50001..75000 then budget = 3
    when 75001..100000 then budget = 4
    when 100001..125000 then budget = 5
    when 125001..150000 then budget = 6
    when 150001..175000 then budget = 7
    when 175001..200000 then budget = 8
    when 200001..225000 then budget = 9
    when 225001..250000 then budget = 10
    when 250001..275000 then budget = 11
    when 275001..300000 then budget = 12
    when 300001..325000 then budget = 13
    when 325001..350000 then budget = 14
    when 350001..400000 then budget = 15
    when 400001..450000 then budget = 16
    when 450001..500000 then budget = 17
    when 500001..550000 then budget = 18
    when 550001..600000 then budget = 19
    when 600001..650000 then budget = 20
    when 650001..700000 then budget = 21
    when 700001..800000 then budget = 22
    when 800001..900000 then budget = 23
    when 900001..1000000 then budget = 24
    when 1000001..1100000 then budget = 25
    when 1100001..1200000 then budget = 26
    when 1200001..1300000 then budget = 27
    when 1300001..1400000 then budget = 28
    when 1400001..1500000 then budget = 29
    when 1500001..2000000 then budget = 30
    when 2000001..10000000 then budget = 31
    end

    html_file = RestClient.get("https://www.leboncoin.fr/ventes_immobilieres/offres/?th=1&pe=#{budget}&location=#{I18n.transliterate(search.address)}&parrot=0&ret=#{type}")
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.mainList ul li').each do |article|
      lbc_id = eval(article.css('.list_item').attribute('data-info').value.gsub(':', '=>'))['ad_listid']
      unless Result.find_by(lbc_id: lbc_id)
        article_url = article.css('.list_item').attribute('href').value
        article_file = RestClient.get('https:' + article_url)
        article_doc = Nokogiri::HTML.parse(article_file)

        article_doc.search('.adview').each do |result|
          result_to_save = Result.new(lbc_id: lbc_id)
          result_img = result.css('.item_image').attribute('data-popin-content')
          unless result_img.nil?
            result_to_save.photo_url = 'https:' + result_img.value
          end
          result_to_save.title = result.css('.no-border').children.text.strip

          result_to_save.price = result.css('.item_price').attribute('content').value.to_i
          # result.css('.line_city').children.css('.value').text.strip
          result.css('.properties .line').each do |line|
            property = line.css('.property').text.strip
            case property
            when "Ville" then result_to_save.address = line.css('.value').text.strip
            when "Pièces" then result_to_save.room_number = line.css('.value').text.to_i
            when "Surface" then result_to_save.surface = line.css('.value').text.to_i
            else next
            end
          end
          result_to_save.description = result.css('.properties_description').text.squish.gsub('Description : ', '')
          result_to_save.search = search
          result_to_save.save!
          ActionCable.server.broadcast(
            "search_#{result_to_save.search.id}",
            html: ApplicationController.new.render_to_string(partial: 'searches/result_card', locals: { result: result_to_save }, layout: false)
          )
        end
      end
    end
  end
end
