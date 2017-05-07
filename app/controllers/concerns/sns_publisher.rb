# coding: utf-8
module SnsPublisher
  extend ActiveSupport::Concern

  def project_publish_to_sns_page(text, project_record, updater_record)
    publish_to_sns_page(
      text,
      project_path(project_record.id),
      project_record.subject,
      project_record.description,
      updater_record.image
    )
  end

  protected

  def publish_to_sns_page(text, uri, name, description, image)
    return if ENV['FACEBOOK_PAGE_SECRET_TOKEN'].nil?
    PostToSnsJob.perform_later(text, uri, name, description, image)
  end
end
