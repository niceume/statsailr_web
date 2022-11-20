require 'sinatra/base'
require 'tilt/erb'
require_relative 'sailr/sailr_wrapper.rb'

class SailrApp < Sinatra::Base
  RootDir = __dir__ 

  configure do
    mime_type :html, 'text/html'
#    mime_type :png,  'image/png'
  end

  get '/' do
    erb :index, :layout => :layout
  end

  get '/sailr/try_sailr' do
    content_type :html
    send_file "sailr/try_sailr.html"
  end

  post '/sailr/run_sailr' do
    script = params["script_text"]
    result = ::SailrWrapper.fork_run_sailr script
    content_type :html
    result
  end
end
