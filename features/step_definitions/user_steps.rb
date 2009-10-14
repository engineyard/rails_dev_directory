When /^I log in as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  click_link(I18n.t('provider.sign_in'))
  fill_in(I18n.t('user.email'), :with => email)
  fill_in(I18n.t('user.password'), :with => password)
  click_button(I18n.t('forms.sign_in'))
end

Given /^a logged in admin user$/ do
  Factory.create(:admin_user)
  visit(login_path)
  fill_in("user_session[email]", :with => "administrator@engineyard.com")
  fill_in("user_session[password]", :with => "mightyadmin")
  click_button(I18n.t('forms.sign_in'))
end

When /^I log out$/ do
  visit(logout_path)
end

Given /^a user "([^\"]*)"$/ do |email|
  Factory.create(:user, :email => email)
end

When /^I follow my reset password link for "([^\"]*)"$/ do |email|
  user = User.find_by_email(email)
  user.reset_perishable_token!
  visit(edit_password_reset_path(user.perishable_token))
end

Then /^"([^\"]*)" should have a perishable token$/ do |email|
  User.find_by_email(email).perishable_token.should_not be_nil
end