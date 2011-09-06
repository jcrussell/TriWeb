class CreateSiteMessages < ActiveRecord::Migration
  def self.up
    create_table :site_messages do |t|
      t.integer :user_id
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :site_messages
  end
end
