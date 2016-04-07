class CreateSshKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :ssh_keys do |t|
      t.belongs_to :account, foreign_key: true
      t.string :title
      t.integer :cat
      t.text :content
      t.string :comment

      t.timestamps
    end
  end
end
