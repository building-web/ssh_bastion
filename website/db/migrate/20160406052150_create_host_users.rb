class CreateHostUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :host_users do |t|
      t.belongs_to :host, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
