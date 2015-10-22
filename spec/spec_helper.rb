$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV["RAILS_ENV"] ||= 'test'
require 'active_support/concern'
require 'byebug'
require "rails"
require 'action_controller/railtie'
require 'action_view/railtie'
require 'rspec/rails'
require 'rails_pattern_view'


class Application < Rails::Application
end

Rails.application.initialize!
