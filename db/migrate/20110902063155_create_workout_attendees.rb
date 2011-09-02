class CreateWorkoutAttendees < ActiveRecord::Migration
  def self.up
    create_table :workout_attendees do |t|
      t.integer :user_id
      t.integer :workout_id
      t.integer :likelihood

      t.timestamps
    end
  end

  def self.down
    drop_table :workout_attendees
  end
end
