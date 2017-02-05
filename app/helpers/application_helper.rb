module ApplicationHelper
  def full_title(page_title)
    base_title = "Ha4go"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def br(text)
    return text if text.nil?
    text = h text
    text.gsub(/\r\n|\r|\n/, '<br/>').html_safe
  end

  require "uri"

  def description_text(text, length = 65_536)
    out = text.to_s
    URI.extract(out, %w(http https)).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"

      out = out.gsub(url, sub_text)
    end
    out.gsub(/\r\n|\r|\n/, '<br/>')[0..(length - 1)].html_safe
  end

  def ago_with_title(target_datetime, link)
    if link.nil?
      %(<span title="#{target_datetime}">#{time_ago_in_words(target_datetime)}</span>).html_safe
    else
      %(<span title="#{target_datetime}">#{link_to(time_ago_in_words(target_datetime), link)}</span>).html_safe
    end
  end

  def updated_at_with_link(record_with_updated_at, link)
    ago_with_title(record_with_updated_at.updated_at, link)
  end

  alias updated_at_ago updated_at_with_link

  def created_at_ago(record_with_created_at, link = nil)
    ago_with_title(record_with_created_at.created_at, link)
  end

  def user_with_face(user_record)
    link_to(
      image_tag(user_record.image, alt: user_record.name, title: user_record.name) + user_record.name,
      user_path(id: user_record.id)
    )
  end

  def project_path_with_comment(project_updates_record)
    project_path(
      id: project_updates_record.project.id,
      anchor: "comment-#{project_updates_record.id}"
    )
  end
end
