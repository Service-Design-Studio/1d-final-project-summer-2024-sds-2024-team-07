require 'capybara/cucumber'
require 'selenium-webdriver'

# Set the path to the downloaded ChromeDriver
Selenium::WebDriver::Chrome::Service.driver_path = File.join(Dir.pwd, 'chromedriver')

Capybara.configure do |config|
  config.default_driver = :selenium_chrome
  config.app_host = 'http://127.0.0.1:3000'
end
