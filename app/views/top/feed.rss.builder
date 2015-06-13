#encoding: UTF-8

xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'ha4go RSS Title'
    xml.author 'Code for Kanazawa'
    xml.description 'ha4go description.'
    xml.link 'https://ha4go.com.'
    xml.language 'jp'

    @projects.each do |article|
      xml.item do
        xml.title = article.subject || ''
        xml.author 'Code for Kanazawa'
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link 'https://ha4go.com/projects/' + article.id.to_s
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
