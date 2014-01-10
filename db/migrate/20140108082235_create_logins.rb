class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :code

      t.timestamps
    end
  end
end
