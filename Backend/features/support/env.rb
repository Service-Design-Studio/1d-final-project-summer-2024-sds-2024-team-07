require 'selenium-webdriver'
require 'capybara/cucumber'
require 'rspec/expectations'
require File.expand_path('../../../config/environment', __FILE__) # Adjust the path as needed
require 'cucumber/rails'

# Include Rails URL helpers and RSpec expectations
World(Rails.application.routes.url_helpers)
World(RSpec::Matchers)

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'features/'
end

# Registering the Selenium driver with Safari
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :safari)
end

# Setting the default driver to Selenium
Capybara.default_driver = :selenium

# Increasing the default wait time
Capybara.default_max_wait_time = 20 # Increase wait time if necessary

Before do
  Capybara.current_session.driver.browser.manage.window.resize_to(1280, 800) # Adjust the window size as needed
end

After do
  Capybara.reset_sessions! # Reset the sessions to avoid invalid session errors
end


# The rest of your env.rb code
