class User < ActiveRecord::Base
    validates :email, :password, presence: true
    has_many :user_sessions
    has_many :projects
    has_many :project_updates
    belongs_to :project
    has_and_belongs_to_many :skills
    has_and_belongs_to_many :projects
end
