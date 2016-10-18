def relative_path(path)
  "#{File.dirname(__FILE__)}/#{path}"
end

def read_relative(path)
  File.read relative_path path
end

YAML.load(read_relative('users.yml')).each do |user|
  auth = JSON.parse(user.to_json, object_class: OpenStruct)
  user = User.from_omniauth(auth)
  user.update({
    email: auth.email,
    description: "My name is #{user.name}"
  })
end
