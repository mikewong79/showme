require 'json'

namespace :songkick do

  desc "Seed database with Songkick data"
  task seed_database: :environment do

    # Place call to Songkick API for Los Angeles Metro Area
    response = HTTParty.get('http://api.songkick.com/api/3.0/metro_areas/17835/calendar.json?apikey=' + ENV['SONGKICK_API_KEY'])
    events_info=JSON.parse(response.body)
    # Grab the number results for this entry area
    total_results = events_info["resultsPage"]["totalEntries"]
    # Calculate the number of calls that needs to be made
    total_calls = 1 + total_results / 50
    current_call = 1
    # Make calls to Songkick API until we have all the results.
    while current_call <= total_calls
        if current_call != 1
            response = HTTParty.get('http://api.songkick.com/api/3.0/metro_areas/17835/calendar.json?apikey=' + ENV['SONGKICK_API_KEY'] + '&page=' + current_call.to_s)
            events_info=JSON.parse(response.body)
        end
        current_call += 1
        events_info = events_info["resultsPage"]["results"]["event"].to_a
        # Run through each of the events individually
        events_info.each do |e|
            # Grab sonckgicks performance id for this event
            performance_id = e["id"]
            # Check if the performance is already in our database, if it is not, start the process, if it is then do nothing
            if Performance.where(songkick_id: performance_id).count == 0
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

                # Assign performance information we want to keep
                performance_name = e["displayName"]
                performance_time = e["start"]["time"]
                performance_date = e["start"]["date"]
                # Add performance to our database and set it as the current_performance
                current_performance = Performance.create(name: performance_name, date: performance_date, time: performance_time, songkick_id: performance_id, venue_id: current_venue.id)
                # Run through each of the "performances" for that event
                e["performance"].each do |artist|
                    # Grab the songkick_id for the artist
                    artist_id = artist["artist"]["id"]
                    # Check our database for that artist
                    if Artist.where(songkick_id: artist_id).count == 0
                        # Assign the information we want about the new artist
                        artist_name = artist["artist"]["displayName"]
                        artist_id = artist["artist"]["id"]
                        # Add artist to our database and set it as the current_artist
                        current_artist = Artist.create(name: artist_name, songkick_id: artist_id)
                    else
                        # If the artist is already in our database, grab it and assign it as the current_artist
                        current_artist = Artist.where(songkick_id: artist_id).first
                    end
                    # Add the current_artist to the current_performance
                    current_performance.artists << current_artist
                end
            end
        end
        # Ensure that we don't hit our API rate limit, 10 calls per second max. Possibly 2 calls every time through.
        sleep(0.21)
    end
  end

  desc "Destroy Performances that have passed"
  task remove_passed: :environment do
    # Find all performances where the date has passed.
    finished = Performance.where("date < ?", Date.today)
    finished.each do |f|
        f.destroy
    end
  end

  desc "Add rdio_id to recently created artits."
  task new_rdio_id: :environment do
    # Find all artists that created in the past hour
    # new_artists = Artist.where("created_at > ?", Time.now-3600)
    non_updated_artists = Artist.where("updated_at < ?", Time.now-38800).limit(300)
    non_updated_artists.each do |new_artist|
        if !new_artist.rdio_id
            response = HTTParty.get('http://developer.echonest.com/api/v4/artist/profile?api_key=' + ENV['ECHONEST_API_KEY'] + '&format=json&id=songkick:artist:' + new_artist.songkick_id.to_s + '&bucket=id:rdio-US')
            rdio_response=JSON.parse(response.body)

            # Check to see if there actually is a rdio_id associated with the artist.
            if rdio_response["response"]["artist"] && rdio_response["response"]["artist"]["foreign_ids"]
                    # If there is, add it to the database.
                    puts rdio_response["response"]["artist"]["foreign_ids"][0]["foreign_id"].gsub('rdio-US:artist:','')
                    new_artist.update!(rdio_id: rdio_response["response"]["artist"]["foreign_ids"][0]["foreign_id"].gsub('rdio-US:artist:',''))
            else
                new_artist.update!(rdio_id: "done")
            end
            # # Ensure that we don't hit our API rate limit, 20 calls per minute max.
            sleep(4)
        else
            puts "rdio id exists"
        end
    end
  end


  desc "Take songkick_id and get rdio_id for initial database."
  task rdio_id: :environment do
    artists = Artist.all
    artists.each do |artist|
        response = HTTParty.get('http://developer.echonest.com/api/v4/artist/profile?api_key=' + ENV['ECHONEST_API_KEY'] + '&format=json&id=songkick:artist:' + artist.songkick_id.to_s + '&bucket=id:rdio-US')
        rdio_response=JSON.parse(response.body)
        # Check to see if there actually is a rdio_id associated with the artist.
        if rdio_response["response"]["artist"] && rdio_response["response"]["artist"]["foreign_ids"]
            # If there is, add it to the database.
            puts rdio_response["response"]["artist"]["foreign_ids"][0]["foreign_id"].gsub('rdio-US:artist:','')
            artist.update!(rdio_id: rdio_response["response"]["artist"]["foreign_ids"][0]["foreign_id"].gsub('rdio-US:artist:',''))
        else
            puts "no response"
        end
        # Ensure that we don't hit our API rate limit, 20 calls per minute max.
        sleep(4)
    end
  end
end
