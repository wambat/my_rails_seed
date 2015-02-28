class Role < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments
  scope :global_roles, where('name in (?)',['admin'])
end
