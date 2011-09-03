class CreateWorkoutComments < ActiveRecord::Migration
  def self.up
    create_table :workout_comments do |t|
      t.integer :user_id
      t.integer :workout_id
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :workout_comments
  end
end
