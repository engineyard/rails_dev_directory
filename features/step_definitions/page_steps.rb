Given /^a page "([^\"]*)" with url "([^\"]*)"$/ do |page_title, url|
  Factory.create(:page, :title => page_title, :url => url)
end

Given /^page "([^\"]*)" has content "([^\"]*)"$/ do |page_title, content|
  Page.find_by_title(page_title).update_attribute(:content, content)
end