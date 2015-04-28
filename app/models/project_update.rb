class ProjectUpdate < ActiveRecord::Base
    validates :description, presence: true
    belongs_to :project
    belongs_to :user
    has_one :user, foreign_key: "id"
end
