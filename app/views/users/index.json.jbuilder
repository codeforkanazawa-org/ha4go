json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password, :description, :facebook_user_id
  json.url user_url(user, format: :json)
end
