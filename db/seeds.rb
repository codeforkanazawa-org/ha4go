# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Skill.first_or_create(
  [
    { name: 'HTML' },
    { name: 'CSS' },
    { name: 'JavaScript' },
    { name: 'PHP' },
    { name: 'Ruby' },
    { name: 'Java' },
    { name: 'Python' },
    { name: 'Perl' },
    { name: 'C++' },
    { name: 'C#' }
  ]
)

[
  { id: 10, name: '議論と調査' },
  { id: 11, name: '企画と試作中' },
  { id: 12, name: '運用中' },
  { id: 13, name: '休止・終了' }
].each do |r|
  Stage.where(r).first_or_create
end

[
  {
    release:     '2016-11-06',
    description: 'UIのバージョンアップ、RSSがあることを明示、全更新通知をメールで受け取る設定追加。'
  },
  {
    release:     '2016-10-02',
    description: 'バージョンアップ。'
  },
  {
    release:     '2016-09-04',
    description: 'RSSに対応など。'
  },
  {
    release:     '2016-09-01',
    description: '少しバージョンアップ。Facebookシェアボタンを復活。'
  },
  {
    release:     '2016-08-09',
    description: '少しバージョンアップ。'
  },
  {
    release:     '2016-07-14',
    description: 'パブリックベータ開始。'
  }
].each do |r|
  AppInformation.where(r).first_or_create
end

# バージョンアップのための処理。最終更新日を記録するようにした
Project.all.each do |project|
  if project.last_commented_at.nil?
    comment_on = project.project_updates.order(id: :desc).first
    project.last_commented_at = comment_on.nil? ? project.updated_at : comment_on.created_at
    project.save!
  end
end
