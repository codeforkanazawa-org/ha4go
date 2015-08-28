# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Skill.first_or_create([
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
])

Stage.first_or_create(
  [
    { name: '議論' },
    { name: '企画・設計' },
    { name: 'プロトタイプ作成' },
    { name: 'ユーザテスト' },
    { name: '運用' },
    { name: '改善・改修' },
    { name: '参加者募集' },
    { name: 'デザイナー募集' },
    { name: 'エンジニア募集' }
  ]
)
