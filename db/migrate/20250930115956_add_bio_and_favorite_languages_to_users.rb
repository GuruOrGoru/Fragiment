class AddBioAndFavoriteLanguagesToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :bio, :text
    add_column :users, :favorite_languages, :string
  end
end
