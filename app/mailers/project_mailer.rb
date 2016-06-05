# coding: utf-8
class ProjectMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)
  default from: 'ha4go@codeforkanazawa.org'

  def tell_create(mails, project)
    @project = project
    # **TODO** controller support i18n
    mail to: mails, subject: '[ha4go] 課題が作成されました'
  end

  def tell_update(mails, project_update)
    @project_update = project_update
    # **TODO** controller support i18n
    mail to: mails, subject: '[ha4go] 課題に更新がありました'
  end

  # test code
  def sendmail_confirm
    @greeting = 'Hi'
    mail to: 'kato@phalanxware.com', subject: 'ActionMailer test'
  end
end
