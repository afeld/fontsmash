require 'cgi'

module Fontsmash
  module Providers
    class Google < Fontsmash::Provider
      def get_fonts
        # TODO fetch from Google (on startup? intermittently?)
        json_str = File.open("#{File.dirname(__FILE__)}/google.json").read
        json_hsh = MultiJson.decode json_str

        fonts = json_hsh['items'].map do |font|
          Fontsmash::Font.new font.slice('family', 'subsets', 'variants')
        end

        fonts
      end

      def get_stylesheet fonts
        family_param = fonts.map{|font|
          font.family
          # TODO handle variant and subsets
        }.join('|')

        family_param = CGI.escape family_param
        resp = HTTParty.get "http://fonts.googleapis.com/css?family=#{family_param}"
        resp.body
      end
    end
  end
end
