class User < ActiveRecord::Base
    has_many :projects
    has_many :project_updates
    belongs_to :project
    has_and_belongs_to_many :skills
    has_and_belongs_to_many :projects

    # OAuth 新規ユーザー作成
    # @param omniauthコールバックパラメータ
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.provider = auth.provider 
            user.uid      = auth.uid
            user.name     = auth.info.name
            user.save
        end
    end

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
