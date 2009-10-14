module I18n
  class << self
    def all_translations
      backend.all_translations
    end
  end

  module Backend
    class Simple
      def all_translations
        send(:init_translations) unless initialized?
        translations
      end
    end
  end
end
