class User < ActiveRecord::Base
    validates :email, :password, presence: true
    has_many :user_sessions
    has_many :projects
    has_many :project_updates
    belongs_to :project
    has_and_belongs_to_many :skills
    has_and_belongs_to_many :projects

    # 必要なスキルを更新
    # @param [Array] skill_names スキル名の配列
    # @return [Boolean]
    def update_skill_ids_by_skill_names(skill_names)
        @before_skill_ids = self.skills.map{|skill| skill.id}
        @after_skill_ids  = []

        if skill_names.present?
            skill_names.each do |skill_name|
                skill = Skill.find_by(name: skill_name)
                if skill.nil?
                    skill = Skill.create(name: skill_name)
                end
                @after_skill_ids.push(skill.id)
            end
        end

        # 追加
        (@after_skill_ids - @before_skill_ids).each do |skill_id|
            self.skills << Skill.find(skill_id)
        end

        # 削除 
        (@before_skill_ids - @after_skill_ids).each do |skill_id|
            self.skills.find(skill_id).destroy()
        end
    end
end
