module Rails
  def self.environment
    ENV['RAILS_ENV'].to_s.downcase
  end

  def self.development?
    environment == 'development'
  end

  def self.production?
    environment == 'production'
  end

  def self.test?
    environment == 'test'
  end
  
  def self.none?
    environment.empty?
  end
end
