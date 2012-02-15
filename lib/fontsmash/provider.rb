module Fontsmash
  class Provider
    class << self
      def get_fonts
        raise "'get_fonts' must be implemented by subclass"
      end
    end
  end
end
