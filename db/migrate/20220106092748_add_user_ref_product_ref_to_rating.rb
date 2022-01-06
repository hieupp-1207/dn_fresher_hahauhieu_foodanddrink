class AddUserRefProductRefToRating < ActiveRecord::Migration[6.1]
  def change
    add_reference :ratings, :user, null: false, foreign_key: true
    add_reference :ratings, :product, null: false, foreign_key: true
  end
end
