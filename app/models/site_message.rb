class SiteMessage < ActiveRecord::Base
  validates :message, :presence => true
  validates_length_of :message, :maximum => 500

  belongs_to :user

  attr_accessible :message, :user

  def internal?
    internal
  end
end
