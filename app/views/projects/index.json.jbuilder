json.array!(@projects) do |project|
  json.extract! project, :id, :user_id, :stage_id, :subject, :description, :user_url, :development_url, :delete_flag
  json.url project_url(project, format: :json)
end
