module Fontsmash
  class Font
    attr_accessor :family, :provider, :variants, :subsets, :backup

    def initialize attrs={}
      attrs.each do |key, val|
        self.send "#{key}=", val
      end
    end
  end
end
