class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|

      t.string :name, limit: 50
      t.string :email, limit: 100
      t.string :password_digest, limit: 30
      t.timestamps
    end
  end
end
