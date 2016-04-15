class CreatePublicKeyBoxes < ActiveRecord::Migration[5.0]
  def change
    create_table :public_key_boxes do |t|
      t.belongs_to :public_key_boxable, polymorphic: true, index: {name: :index_public_key_boxes_on_public_key_boxable}
      t.string :title
      t.text :key
      t.string :comment

      t.timestamps
    end
  end
end
