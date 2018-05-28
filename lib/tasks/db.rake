namespace :db do
  desc "Fill DB with 50 random addresses"
  task :fill, [] => :environment do
    lat_min = 55.637813
    lon_min = 37.470569
    lat_max = 55.869380
    lon_max = 37.739734
    key = Rails.application.credentials.google_api_key

    connect = Faraday.new("https://maps.googleapis.com/")
    count = 0

    loop do
      lat = SecureRandom.random_number(lat_max - lat_min) + lat_min
      lon = SecureRandom.random_number(lon_max - lon_min) + lon_min
      response = JSON.parse(
        connect.get('maps/api/geocode/json', latlng: "#{lat},#{lon}", key: key, language: :ru).body
      )
      puts "request"
      next unless response["results"].first["types"].include? "street_address"
      puts "Lucky"
      params = response["results"].first
      Building.create address: params["formatted_address"],
                      longitude: params["geometry"]["location"]["lng"],
                      latitude: params["geometry"]["location"]["lat"]
      count += 1
      break if count == 50
    end
  end
end
