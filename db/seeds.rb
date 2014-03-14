# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by(name: role)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.new
user.username = ENV['ADMIN_USERNAME'].dup 
user.email =  ENV['ADMIN_EMAIL'].dup 
#user.access_token = SecureRandom.hex 
user.password = ENV['ADMIN_PASSWORD'].dup 
user.password_confirmation = ENV['ADMIN_PASSWORD'].dup
user.save

puts 'user: ' << user.username
user.add_role :admin
