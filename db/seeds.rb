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
