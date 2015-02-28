Given(/^'(.*):(.*)' user exists with roles '(.*)'$/) do |username, password, roles|
  r=Role.where(["name in (?)",roles.split(',')])
  u=build(:user, email: username, password: password, roles: r)
  u.save!
end

When(/^navigated to '(.*)'$/) do |path|
  #TODO: possibly unsafe
  visit(eval path)
end

When(/^I press "(.*?)" button$/) do |arg1|
  click_button (arg1)
end


When(/^(?:I )?hit [\'"](.*?)[\'"]$/) do |link|
  click_link link
end

When(/^(?:I )?select [\'"](.*?)[\'"] in a (.*) field$/) do |value, field|
  select(value, from: field)
end


Then(/^I should see "(.*?)" there$/) do |content|
  expect(page).to have_content content
end

Then(/^I should not see "(.*?)" there$/) do |content|
  expect(page).not_to have_content content
end

When(/^(?:I )?enter [\'"](.*?)[\'"] in (?:a )?(.*) field$/) do |value, field|
  fill_in(field, with: value)
end

Then(/^I should be redirected to [\'"](.*?)[\'"] page$/) do |url|
  u1=URI.parse(current_url).path
  u2=eval url
  u1.should == u2
end
