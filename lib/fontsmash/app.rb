module Fontsmash
  class App < Sinatra::Base
    enable :logging
    set :root, File.join(File.dirname(__FILE__), '..')


    get '/css' do
      Fontsmash.get_stylesheet params['family']
    end
  end
end
