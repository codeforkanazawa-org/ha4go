class ProjectUpdate < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many   :project_update_histories
  mount_uploader :comment_image, CommentImageUploader
end
