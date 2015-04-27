class User < ActiveRecord::Base
    validates :email, :password, presence: true
    has_many :user_sessions
    has_many :projects
    has_many :project_updates
end
