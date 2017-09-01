require 'capybara'
require 'capybara/rspec'
require 'cucumber'
require 'selenium-webdriver'

include Capybara::DSL

Capybara.default_driver = :selenium

