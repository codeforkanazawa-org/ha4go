class Skill < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects

  def self.skill_members
    includes(:users).all
  end
end
