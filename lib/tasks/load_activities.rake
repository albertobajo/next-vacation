require 'json'

# TO_REFACTOR
namespace :activities do
  desc 'Load activities from the given JSON file'
  task :load, [:filepath, :city_name] => :environment do |task, args|
    file = File.read args[:filepath]
    data_array = JSON.parse(file)

    ActiveRecord::Base.transaction do
      city = City.find_or_create_by(name: args[:city_name])

      Activity.with_city(city.name).destroy_all

      data_array.each do |data|
        category = Category.find_or_create_by(name: data['category'])
        location = Location.find_or_create_by(name: data['location'])
        district = District.find_or_create_by(
          name: data['district'],
          city: city
        )

        activity = Activity.find_or_create_by(name: data['name']) do |a|
          a.minutes_spent = data['hours_spent'] * 60

          # Associations
          a.category = category
          a.location = location
          a.district = district

          # Coordinates
          latlng = data['latlng']
          a.lonlat = "POINT(#{latlng[1]} #{latlng[0]})"

          # Opening Hours
          data['opening_hours'].each do |day, hours|
            hours.each do |hour|
              a.opening_hours << OpeningHour.new do |oh|
                t1, t2 = hour.split('-')
                oh.opens_at = Time.parse(t1).seconds_since_midnight.to_i
                oh.closes_at = Time.parse(t2).seconds_since_midnight.to_i
                oh.day_of_week = day.to_sym
              end
            end
          end
        end

        puts activity.inspect
      end

      puts
      puts "There are #{Activity.count} activities in the database."
    end
  end
end
