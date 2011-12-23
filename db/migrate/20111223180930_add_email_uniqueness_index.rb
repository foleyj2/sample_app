class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    # race condition from the controller if double click on creation
    # fixed by having DB do uniqueness check
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
  end
end
