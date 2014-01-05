RSpec.configure do |config|
  #https://github.com/plataformatec/devise/wiki/How-To:-Controllers-tests-with-Rails-3-(and-rspec)
  config.include Devise::TestHelpers, :type => :controller
end
