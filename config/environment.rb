# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'byebug'
require 'yaml'
require 'twitter'
require 'awesome_print'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

API_KEYS = YAML::load(File.open('config/app_secret.yaml'))

TWITTER_CLIENT = Twitter::REST::Client.new do |config|
	config.consumer_key = API_KEYS["development"]["twitter_api_key_id"]
	config.consumer_secret = API_KEYS["development"]["twitter_secret_key_id"]
	config.access_token = API_KEYS["development"]["twitter_token_key_id"]
	config.access_token_secret = API_KEYS["development"]["twitter_secret_token_key"]
end 
