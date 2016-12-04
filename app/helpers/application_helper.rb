module ApplicationHelper
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

  def updated_at_with_link(record_with_updated_at, link)
    r = record_with_updated_at
    "<span title=\"#{r.updated_at}\">#{link_to(time_ago_in_words(r.updated_at), link)}</span>".html_safe
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
