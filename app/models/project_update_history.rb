class ProjectUpdateHistory < ActiveRecord::Base
  belongs_to :project_update
  belongs_to :user
end
