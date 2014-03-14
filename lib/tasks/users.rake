namespace :users do

  desc "Generate access token for users without one"
  task :generate_access_token => [:environment] do
    counter = 0

    users = User.where(:access_token => nil)
    users.each do |user|
      user.update_attribute(:access_token, SecureRandom.hex)
      counter = counter + 1
    end

    puts "#{counter} users updated with access_tokens"
  end

end