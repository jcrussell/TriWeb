class AddNameAndRoleToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :roles_mask, :integer, :default => 0
  end

  def self.down
    remove_column :users, :roles_mask
    remove_column :users, :name
  end
end
