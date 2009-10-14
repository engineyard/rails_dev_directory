require 'test/test_helper'
require 'babilu'

module SharedSetup

  TRANSLATIONS = {
    :en => {
      :hello => "Hello World"
    },
    :no => {
      :hello => "Hei verden"
    }
  }

  def setup
    I18n.load_path = []
    I18n.backend = I18n::Backend::Simple.new
    I18n.default_locale = :en
    TRANSLATIONS.each{|l,t| I18n.backend.store_translations(l,t) }
  end

end

class BabiluI18nExtensionsTest < Test::Unit::TestCase

  include SharedSetup

  def test_all_translations_should_be_defined_on_simple_backend
    assert I18n::Backend::Simple.instance_methods.include?("all_translations")
  end

  def test_all_translations_should_return_a_hash_with_all_translations_in_all_locales
    assert_equal TRANSLATIONS, I18n.all_translations
  end

end


class BabiluTest < Test::Unit::TestCase

  include SharedSetup

  def test_translations_should_return_all_translations
    assert_equal TRANSLATIONS, Babilu.translations
  end

  def test_default_locale_should_use_i18n_default_locale
    assert_equal I18n.default_locale, Babilu.default_locale
  end

end
