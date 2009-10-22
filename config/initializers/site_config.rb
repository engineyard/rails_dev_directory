def site_config(key = nil)
  file = "#{Rails.root}/config/site_config.yml"
  config = File.exists?(file) ? HashWithIndifferentAccess.new(YAML.load(File.read(file))) : {}
  return config[key] if key
  config
end