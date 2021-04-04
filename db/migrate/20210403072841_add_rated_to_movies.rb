class AddRatedToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :rated, :integer
  end
end
