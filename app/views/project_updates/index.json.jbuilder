json.array!(@project_updates) do |project_update|
  json.extract! project_update, :id, :project_id, :description
  json.url project_update_url(project_update, format: :json)
end
