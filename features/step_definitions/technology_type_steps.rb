Given /^primary technology types "([^\"]*)"$/ do |types|
  types = types.split(',')
  types.each do |type|
    TechnologyType.create!(:name => type)
  end
end

Given /^secondary technology types "([^\"]*)"$/ do |types|
  types = types.split(',')
  types.each do |type|
    TechnologyType.create!(:name => type)
  end
end

Given /^pre checked technology types "([^\"]*)"$/ do |types|
  types = types.split(',')
  types.each do |type|
    TechnologyType.create!(:name => type, :checked => true)
  end
end

Given /there are no technology types/ do
  TechnologyType.destroy_all
end