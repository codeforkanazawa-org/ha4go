module ApplicationHelper
  def br(text)
    return text if text.nil?
    text = h text
    text.gsub(/\r\n|\r|\n/, '<br/>').html_safe
  end

  require "uri"

  def description_text(text)
    text = text.to_s
    URI.extract(text, ['http', 'https']).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"

      text.gsub!(url, sub_text)
    end
    text.gsub!(/\r\n|\r|\n/, '<br/>')
    text.html_safe
  end
end
