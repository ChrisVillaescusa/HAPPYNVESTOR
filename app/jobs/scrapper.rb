class Scrapper < ApplicationJob

  def perform
    html_file = RestClient.get('http://www.seloger.com/list.htm?tri=initial&idtypebien=1&pxmax=500000&idtt=2&ci=330063&naturebien=1,2,4')
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('article').each do |article|
      p sl_id = article.attribute('id')
      # next if Result.find_by(sl_id: sl_id)
      # article_file = open(article.search('.listing-link').attribute('href'))
      # p article_doc = Nokogiri::HTML(article_file)
    end
  end
end
