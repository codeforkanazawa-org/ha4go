module UsersHelper
  def name_and_link(user)
    link_to(user.name, user_path(id: user.id))
  end
end
