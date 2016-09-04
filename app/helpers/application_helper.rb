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
end
