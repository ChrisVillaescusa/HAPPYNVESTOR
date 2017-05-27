class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :demo ]

  def home
    @search = Search.new
    @types = Type.all.order(name: :asc)
    # Search.find(36).results.create
  end

  def demo
    search = Search.find(23)
    demo = [
            {
              photo: 'http://v.seloger.com/s/width/800/visuels/0/z/o/b/0zobmgujiq9k4jq213kv7qle4mxjg21r11prswpwg.jpg',
              address: '50 Rue de la Croix-Blanche, 33000 BORDEAUX',
              city: 'bordeaux',
              type: 'Maison',
              surface:  115,
              price: 309000,
              description: "Dans un quartier calme et recherché maison de style Arcachonnaise en retrait de rue avec jardin d'accueil composée d'un vaste salon avec cuisine ouverte entièrement aménagée quatre chambres dont une en rez-de-chaussée salle d'eau garage et buanderie Jardin sans vis à vis. Proche de tous commerces écoles et transports Prévoir quelques travaux de finitions au goût de chacun."
            },
            {
              photo: 'http://v.seloger.com/s/width/800/visuels/1/9/8/u/198ud54du9tp10tgj0xq4g6099gienxt58yjh1fy8.jpg',
              address: '25 Rue Carle Vernet, 33000 BORDEAUX',
              city: 'bordeaux',
              type: 'Maison',
              surface: 90,
              price: 319500
            },
            {
              photo: 'http://v.seloger.com/s/width/800/visuels/1/x/c/0/1xc0gm1qz8p7jwfbir8zt5pxwcu6mtn47lgrlimm8.jpg',
              address: '83 Rue de Marmande, 33000 BORDEAUX',
              city: 'bordeaux',
              type: 'Maison',
              surface: 75,
              price: 256000
            }
          ]
    results = 0
    demo.each do |result|
      result_to_save = search.results.new(
        price: result[:price],
        address: result[:city]
      )
      result_to_save.photo_url = result[:photo]
      result_to_save.save!
      results += 1
    end
    sms_api = CALLR::Api.new(ENV['CALLR_LOGIN'], ENV['CALLR_PASSWORD'])
    total_results = results
    user_phone = search.user.phone.gsub(/^0/, '+33')
    begin
      sms_api.call('sms.send', 'SMS', "+33683788434", "Nous avons trouvé 3 nouvelles anonces pour votre recherche :, http://happynvestor.herokuapp.com/search/23", nil)
    rescue CALLR::CallrException => e
      puts e.msg
      byebug
    end
  end
end
