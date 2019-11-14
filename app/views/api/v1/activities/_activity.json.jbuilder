json.type 'Feature'

json.properties do
  json.name activity.name

  json.opening_hours do
    %w[mo tu we th fr sa su].each do |day|
      json.set! day, activity.opening_hours.select { |h| h.day_of_week == day }.map(&:time_to_s)
    end
  end

  json.hours_spent activity.hours_spent
  json.category activity.category.name
  json.location activity.location.name
  json.district activity.district.name
end

json.geometry do
  json.type 'Point'
  json.coordinates [activity.lonlat.x, activity.lonlat.y]
end
