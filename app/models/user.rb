class User < ActiveRecord::Base
    validates :email, :password, presence: true
end
