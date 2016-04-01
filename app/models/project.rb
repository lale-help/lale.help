class Project < ActiveRecord::Base

  belongs_to :working_group
  
  validates :name, presence: true
  
  validates :working_group_id, presence: true
  validates_uniqueness_of :name, scope: :working_group

  has_many :roles, dependent: :destroy

  has_many :users,   ->{ distinct }, through: :roles
  has_many :admins,  ->{ Role.admin }, through: :roles, source: :user

end
