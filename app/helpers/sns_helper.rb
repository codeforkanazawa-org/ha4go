module SnsHelper
    def facebook_share_btn(url)
        html = sprintf('<div class="fb-share-button" data-href="%s" data-layout="button_count" data-action="like" data-show-faces="true"></div>', url);
        return html.html_safe;
    end

    def twitter_share_btn(url)
        html = sprintf('<a class="twitter-share-button" href="%s" data-dnt="true">Tweet</a>', url);
        return html.html_safe;
    end
end
