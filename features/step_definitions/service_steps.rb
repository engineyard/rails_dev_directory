Given /^a "([^\"]*)" service "([^\"]*)"$/ do |category_name, service_name|
  category = ServiceCategory.find_by_name(category_name)
  Service.make(:name => service_name, :category => category)
end

Given /^the following services:$/ do |services|
  services.map_column!('category') do |category_name|
    category = ServiceCategory.find_by_name(category_name)
  end
  services.hashes.each do |row|
    Service.make(:name => row['service'], :category => row['category'])
  end
end

Given /^primary services "([^\"]*)"$/ do |types|
  types = types.split(/, ?/)
  types.each do |type|
    Service.make(:name => type)
  end
end

Given /^secondary services "([^\"]*)"$/ do |types|
  types = types.split(/, ?/)
  types.each do |type|
    Service.make(:name => type)
  end
end

Given /^pre checked services "([^\"]*)"$/ do |types|
  types = types.split(/, ?/)
  types.each do |type|
    Service.make(:name => type, :checked => true)
  end
end

Given /there are no services/ do
  Service.destroy_all
end