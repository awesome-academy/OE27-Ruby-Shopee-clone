class RemoveCountFromRating < ActiveRecord::Migration[5.2]
  def change
    remove_column :ratings, :avg_star
    remove_column :ratings, :count_rate
  end
end
