# coding: utf-8
class Project < ActiveRecord::Base
    validates :subject, presence: true
    has_many :project_updates
    belongs_to :user
    has_and_belongs_to_many :users
    has_and_belongs_to_many :skills
    belongs_to :stage

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

    # 必要なスキルを更新
    # @param [Array] skill_names スキル名の配列
    # @return [Boolean]
    def update_skill_ids_by_skill_names(skill_names)
        @before_skill_ids = self.skills.map{|skill| skill.id}
        @after_skill_ids  = []
        skill_names.each do |skill_name|
            skill = Skill.find_by(name: skill_name)
            if skill.nil?
                skill = Skill.create(name: skill_name)
            end
            @after_skill_ids.push(skill.id)
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

    # メールを送るユーザーを取得
    def send_mail_users
      send_users = self.users
      me = self.user
      if send_users.select{|u| u['user_id'] == me['user_id']}.empty?
        send_users.push self.user
      end
      return send_users
    end
end
