class User < ActiveRecord::Base
    validates :email, :password, presence: true
    has_many :user_sessions
end
