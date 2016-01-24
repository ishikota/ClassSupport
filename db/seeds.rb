# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

User.create!(name: "Example User",
             student_id: "f1234567",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name = Faker::Name.name
  student_id = "f" + (1000000+n).to_s
  password = "password"
  User.create!(name: name, student_id: student_id,
               password: password,
               password_confirmation: password)
end
