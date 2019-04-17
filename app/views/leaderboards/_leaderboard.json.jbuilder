json.extract! leaderboard, :id, :user_id, :genre_id, :subgenre_id, :value, :created_at, :updated_at
json.url leaderboard_url(leaderboard, format: :json)
