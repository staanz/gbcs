class RemoveGraduationFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :graduation, :datetime
  end
end
