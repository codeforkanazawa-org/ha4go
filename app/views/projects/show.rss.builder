#encoding: UTF-8

xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title   @project.subject
    xml.author  @project.user.name
    xml.description @project.description
    protocol = 'http'
    protocol + 's' if ENV['USE_HTTPS'].to_i > 0
    url =  "#{protocol}://#{ENV['APP_HOST']}/projects/#{@project.id}"
    xml.link url
    xml.language 'jp'

    @project.project_updates.each do |article|
      xml.item do
        xml.title article.created_at.to_s
        xml.author article.user.name
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link "#{url}#comment-" + article.id.to_s
        xml.guid article.id

        text = article.description
        # if you like, do something with your content text here e.g. insert image tags.
        # Optional. I'm doing this on my website.
        #         if article.image.exists?
        #           image_url = article.image.url(:large)
        #           image_caption = article.image_caption
        #           image_align = ''
        #           image_tag = "
        # <p><img src='" + image_url +  "' alt='" + image_caption + "' title='" + image_caption + "' align='" + image_align  + "' /></p>
        # "
        #           text = text.sub('{image}', image_tag)
        #         end
        xml.description '<p>' + text + '</p>'
      end
    end
  end
end
