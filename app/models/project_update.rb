class ProjectUpdate < ActiveRecord::Base
  validates :description, presence: true
  belongs_to :project
  belongs_to :user
end
