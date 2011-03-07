class Project < ActiveRecord::Base
  has_many :tasks

  default_scope order(:name)
end
