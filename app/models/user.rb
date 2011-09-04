class User < ActiveRecord::Base
  # Important! Never change the order of these, only append to the end for new roles
  ROLES_MASK = %w(admin moderator)
  # Admin: can assign roles, post site-wide news
  # Moderator: can edit/delete other user's workouts, remove comments

  validates :name, :presence => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  easy_roles :roles_mask, :method => :bitmask

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  has_many :workouts, :dependent => :destroy
  has_many :workout_attendees, :dependent => :destroy
  has_many :workout_comments, :dependent => :destroy
end
