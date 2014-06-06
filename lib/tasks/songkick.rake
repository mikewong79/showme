require 'json'

namespace :songkick do

  desc "Seed database with Songkick data"
  task seed_database: :environment do

    # Place call to Songkick API for Los Angeles Metro Area

    response = HTTParty.get('http://api.songkick.com/api/3.0/metro_areas/17835/calendar.json?apikey=' + ENV['SONGKICK_API_KEY'])
    events_info=JSON.parse(response.body)
    events_info = events_info["resultsPage"]["results"]["event"].to_a
    # Run through each of the events individually
    events_info.each do |e|
        # Grab songkick_id for the venue
        venue_id = e["venue"]["id"]
        # Check to see if venue is in our database already using the songkick_id
        if Venue.where(songkick_id: venue_id).count == 0
            # Make call to Songkick API for venue information if it's not in our database.
            venue_response = HTTParty.get('http://api.songkick.com/api/3.0/venues/' + venue_id.to_s + '.json?apikey='+ ENV['SONGKICK_API_KEY'])
            venue_info = JSON.parse(venue_response.body)
            venue_info = venue_info["resultsPage"]["results"]["venue"]
            # Assign information that we want to keep.
            venue_name = venue_info["displayName"]
            venue_lat = venue_info["lat"]
            venue_lng = venue_info["lng"]
            venue_street = venue_info["street"]
            venue_city = venue_info["city"]["displayName"]
            venue_state = venue_info["city"]["state"]["displayName"]
            venue_zip = venue_info["zip"]
            venue_web = venue_info["website"]
            venue_phone = venue_info["phone"]
            # Add venue into our database and set it as the current_venue
            current_venue = Venue.create(name: venue_name, lat: venue_lat, lng: venue_lng, songkick_id: venue_id, street_address_1: venue_street, city: venue_city, state: venue_state, zip: venue_zip, website: venue_web, phone: venue_phone)
        else
            # If it's already in the database, set it as the current_venue
            current_venue = Venue.where(songkick_id: venue_id).first
        end

        # Assing performance information we want to keep
        performance_name = e["displayName"]
        performance_time = e["start"]["time"]
        performance_date = e["start"]["date"]
        performance_id = e["id"]
        current_performance = Performance.create(name: performance_name, date: performance_date, time: performance_time, songkick_id: performance_id, venue_id: current_venue.id)

        e["performance"].each do |artist|

            artist_id = artist["artist"]["id"]
            if Artist.where(songkick_id: artist_id).count == 0
                artist_name = artist["artist"]["displayName"]
                artist_id = artist["artist"]["id"]
                current_artist = Artist.create(name: artist_name, songkick_id: artist_id)
            else
                current_artist = Artist.where(songkick_id: artist_id).first
                # puts "your are in the else"
                # puts current_artist.id
            end

            current_performance.artists << current_artist
        end
    end
  end
end
