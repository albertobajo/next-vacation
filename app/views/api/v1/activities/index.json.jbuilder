json.type 'FeatureCollection'

json.features @activities, partial: 'api/v1/activities/activity', as: :activity
