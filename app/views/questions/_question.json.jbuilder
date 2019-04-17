json.extract! question, :id, :name, :qtype, :subgenre_id, :created_at, :updated_at
json.url question_url(question, format: :json)
