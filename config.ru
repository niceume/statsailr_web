require 'bundler/setup'
Bundler.require(:default) # require gems specified in Gemfile

require File.absolute_path("app.rb")

require File.absolute_path("sassc/sassc_rack.rb")

use Rack::Sassc

run SailrApp
