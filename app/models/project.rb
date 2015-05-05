class Project < ActiveRecord::Base
    validates :subject, presence: true
    has_many :project_updates
    belongs_to :user
    has_and_belongs_to_many :users
    has_and_belongs_to_many :skills

    # プロジェクトを編集可能なユーザーかどうか
    # @param [Integer] user_id
    # @return [Boolean]
    def editable_user_id?(user_id)
        if user_id == self.user_id
            return true
        else
            return false
        end
    end 
end
