json.extract! user, :id, :name, :email, :terms_of_service, :created_at, :updated_at
json.url user_url(user, format: :json)
