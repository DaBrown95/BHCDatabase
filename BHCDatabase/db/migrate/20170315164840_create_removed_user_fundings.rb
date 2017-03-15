class CreateRemovedUserFundings < ActiveRecord::Migration[5.0]
  def change
    create_table :removed_user_fundings do |t|
      t.references :funder, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
