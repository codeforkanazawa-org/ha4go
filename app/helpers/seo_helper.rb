# coding: utf-8
module SeoHelper
  def default_meta_tags
    {
      description: "課題を深く知る市民とシビックテックの情報交換サイト、はじめました。",
      og: {
        title: 'Ha4go',
        site_name: 'Ha4go',
        type: 'article',
        url: request.url,
        description: '課題を深く知る市民とシビックテックの情報交換サイト、はじめました。',
        locale: 'ja_jp',
        image: request.protocol + request.host + asset_path('ha4go_icon.png')
      },
      fb: {
        app_id: ENV['FACEBOOK_APP_ID']
      }
    }
  end
end
