Feature: Admin can login newerly created system 
  In order to update content
  As a system administrator 
  I want to be authenticated to perform actions 
  
  Scenario:
    Given 'admin@adminhq.com:admin' user exists with roles 'admin'
    When navigated to 'root_path'
    And I hit 'Login'  
    And I enter 'admin@adminhq.com' in user_email field 
    And enter 'admin' in user_password field 
    And I press "Sign in" button
    Then I should be redirected to 'admin_root_path' page 
    And I should see "Welcome, administrator!" there
