class ProjectUpdate < ActiveRecord::Base
  validates :description, presence: true
  belongs_to :project
  belongs_to :user
  has_many   :project_update_histories
end
