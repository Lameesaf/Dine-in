class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :status
      t.references :reservation, foreign_key: true
      t.references :chef, foreign_key: true
      t.references :user, foreign_key: true
      t.references :restaurant, foreign_key: true


      t.timestamps
    end
  end
end
