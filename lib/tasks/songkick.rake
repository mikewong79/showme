require 'json'

namespace :songkick do

  desc "Seed database with Songkick data"
  task seed_database: :environment do

    #place API call

    response = HTTParty.get('http://api.songkick.com/api/3.0/metro_areas/17835/calendar.json?apikey=' + ENV['SONGKICK_API_KEY'])
    Venue.create()


  end

end
