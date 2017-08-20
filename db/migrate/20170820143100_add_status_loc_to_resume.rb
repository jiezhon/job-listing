class AddStatusLocToResume < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :location_id, :integer, :index => true
    add_column :resumes, :status, :string
  end
end
