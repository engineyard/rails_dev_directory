def site_config(key = nil)
  config = HashWithIndifferentAccess.new(YAML.load(File.read("#{Rails.root}/config/site_config.yml")))
  return config[key] if key
  config
end