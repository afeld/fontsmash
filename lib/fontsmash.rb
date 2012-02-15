require 'active_support/core_ext/hash/slice'
Dir["#{File.dirname(__FILE__)}/fontsmash/*.rb"].each {|file| require file }


module Fontsmash
  @fonts = {}

  class << self
    def add_font font
      @fonts[font.family] = font
    end

    def all_fonts
      @fonts
    end

    def get_stylesheet fonts_str
      families = fonts_str.split '|'

      fonts_by_provider = {}
      families.each do |family|
        font = self.all_fonts[family]
        raise "'#{family}' not found" if font.nil?
        
        fonts_by_provider[font.provider] ||= []
        fonts_by_provider[font.provider] << font
      end

      stylesheets = fonts_by_provider.map do |provider, fonts|
        provider.get_stylesheet fonts
      end

      stylesheets.join "\n"
    end
  end
end

# TODO make this smarter
Dir["#{File.dirname(__FILE__)}/fontsmash/providers/*.rb"].each {|file| require file }

# add fonts from each provider
Fontsmash::Providers.constants.each do |class_name|
  klass = Fontsmash::Providers.const_get class_name
  fonts = klass.get_fonts
  fonts.each do |font|
    font.provider = klass
    Fontsmash.add_font font
  end
end
