class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  scope :for_role, lambda {|rolename| joins(:role).where("roles.name" => rolename)}
end
