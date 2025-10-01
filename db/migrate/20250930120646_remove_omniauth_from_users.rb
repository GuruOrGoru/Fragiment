class RemoveOmniauthFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_index :users, [ :provider, :uid ] if index_exists?(:users, [ :provider, :uid ])
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
  end
end
