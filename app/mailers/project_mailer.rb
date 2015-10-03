# coding: utf-8
class ProjectMailer < ApplicationMailer
  default from: 'ha4go@codeforkanazawa.org'

  def tell_create(mails, project)
    @project = project
    mail to: mails, subject: 'プロジェクトが作成されました'
  end

  def tell_update(mails, project_update)
    @project_update = project_update
    mail to: mails, subject: 'プロジェクトに更新がありました'
  end

  # test code
  def sendmail_confirm
    @greeting = 'Hi'
    mail to: 'kato@phalanxware.com', subject: 'ActionMailer test'
  end
end
