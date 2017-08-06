class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :job_id, :index => true
      t.string :city
      t.string :address
      t.integer :quantity
      t.timestamps
    end
  end
end
