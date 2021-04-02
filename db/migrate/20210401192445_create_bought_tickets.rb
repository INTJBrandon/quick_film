class CreateBoughtTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :bought_tickets do |t|
      t.string :name
      t.integer :user_id
      t.integer :movie_id
      t.integer :quantity
    end
  end
end
