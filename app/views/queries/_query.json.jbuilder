json.extract! query, :id, :kind, :words, :category, :send_to_mail, :response_status, :response_error, :created_at, :updated_at
json.url query_url(query, format: :json)
