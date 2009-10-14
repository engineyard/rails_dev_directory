class Country
  attr_accessor :name, :code
  
  def initialize(array)
    self.name = array.last
    self.code = array.first
  end
  
  class << self
    def slugs
      I18n.t('countries').map { |c| c.last.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s/,'-') }
    end
    
    def from_slug(slug)
      Country.new(I18n.t('countries').select { |code, country| country.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s/,'-') == slug }.flatten)
    end
    
    def slug_for(select_code)
      I18n.t('countries').select do |code, country|
        code.to_s.downcase == select_code.to_s.downcase 
      end.flatten.last.to_s.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s/,'-')
    end

    def path_for(select_code)
      I18n.t('countries').select do |code, country|
        code.to_s.downcase == select_code.to_s.downcase 
      end.flatten.last.to_s.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s/,'_') + "_path"
    end
    
    
  end
end