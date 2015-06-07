class ProjectMailer < ApplicationMailer
    default from: "info@ha4go.jp"

    def tell_create(user, project)
        @project = project
        mail to: user.email, subject: "プロジェクトが作成されました"
    end

    def tell_update(user, project_update)
        @project_update = project_update
        mail to: user.email, subject: "プロジェクトに更新がありました"
    end
end
