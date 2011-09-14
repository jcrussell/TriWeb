class Workout < ActiveRecord::Base
  TYPES = %w(Swim Bike Run Brick Race Social Other)

  validates :name, :description, :what, :time, :presence => true
  validates_inclusion_of :what, :in => TYPES
  validates_datetime :time, :after => :now

  attr_accessible :name, :description, :what, :time, :created_at

  has_many :workout_attendees, :dependent => :destroy
  has_many :workout_comments, :dependent => :destroy

  belongs_to :user # user that created the workout

  # Returns a set of workouts that are between first and last, ordered by time
  def self.find_by_range(first, last)
    Workout.find(:all, :conditions => {:time => (first..last)}, :order => "time")
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ? OR description LIKE ?',
        "%#{search}%", "%#{search}%"], :order => "time", :limit => 25)
    else
      find(:all)
    end
  end
end
