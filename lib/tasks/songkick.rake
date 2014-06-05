require 'json'

namespace :songkick do

  desc "Seed database with Songkick data"
  task seed_database: :environment do

    #place API call

    response = HTTParty.get('http://api.songkick.com/api/3.0/metro_areas/17835/calendar.json?apikey=' + ENV['SONGKICK_API_KEY'])
    events_info=JSON.parse(response.body)
    events_info = events_info["resultsPage"]["results"]["event"].to_a
    venue_name = events_info[0]["venue"]["displayName"]
    venue_lat = events_info[0]["venue"]["lat"]
    venue_lng = events_info[0]["venue"]["lng"]
    venue_id = events_info[0]["venue"]["id"]
    current_venue = Venue.create(name: venue_name, lat: venue_lat, lng: venue_lng, songkick_id: venue_id)
    artist_name = events_info[0]["performance"][0]["artist"]["displayName"]
    artist_id = events_info[0]["performance"][0]["artist"]["id"]
    current_artist = Artist.create(name: artist_name, songkick_id: artist_id)
    performance_name = events_info[0]["displayName"]
    performance_time = events_info[0]["start"]["time"]
    performance_date = events_info[0]["start"]["date"]
    performance_id = events_info[0]["id"]
    current_performance = Performance.create(name: performance_name, date: performance_date, time: performance_time, songkick_id: performance_id, venue_id: current_venue.id)
    current_performance.artists << current_artist
  end

end
