class Project < ActiveRecord::Base
    validates :subject, presence: true
    has_many :project_updates
    belongs_to :user
    has_one :user, foreign_key: "id"
    has_and_belongs_to_many :users
end
