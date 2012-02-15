module Fontsmash
  module Providers
    class Google < Fontsmash::Provider
      class << self
        def get_fonts
          json_str = File.open("#{File.dirname(__FILE__)}/google.json").read
          json_hsh = MultiJson.decode json_str

          fonts = json_hsh['items'].map do |font|
            Fontsmash::Font.new(
              family: font['family'],
              provider: :google
            )
          end

          fonts
        end
      end
    end
  end
end
