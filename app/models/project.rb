class Project < ActiveRecord::Base
    validates :subject, presence: true
    has_many :project_updates
    belongs_to :user
end
