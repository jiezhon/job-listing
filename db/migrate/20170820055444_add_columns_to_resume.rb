class AddColumnsToResume < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :uuid, :string
    add_column :resumes, :name, :string
    add_column :resumes, :email, :string
    add_column :resumes, :cellphone, :string

    add_index :resumes, :uuid, :unique => true
    add_index :resumes, :job_id
    add_index :resumes, :user_id
  end
end
