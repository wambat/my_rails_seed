When(/^I have created "(.*)" (.*)$/) do |name, model|
  s= %Q{
    And navigated to 'admin_#{model.pluralize}_path'}
  name.split(',').each do |n|
    n.strip!
    s+= %Q{
    When hit "New #{model.classify}"
    And enter "#{n}" in a #{model}_name field
    And I press "Create #{model.titleize}" button
    Then I should be redirected to 'admin_#{model.pluralize}_path' page
    And I should see "#{n}" there
}
  end
  steps s
end
