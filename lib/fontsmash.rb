Dir["#{File.dirname(__FILE__)}/fontsmash/*.rb"].each {|file| require file }


module Fontsmash
  @fonts = {}

  class << self
    def add_font font
      @fonts[font.family] = font
    end

    def fonts
      @fonts
    end
  end
end

# TODO make this smarter
Dir["#{File.dirname(__FILE__)}/fontsmash/providers/*.rb"].each {|file| require file }

Fontsmash::Providers.constants.each do |class_name|
  klass = Fontsmash::Providers.const_get class_name
  fonts = klass.get_fonts
  fonts.each{|f| Fontsmash.add_font f }
end
