class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.belongs_to :from, null: false, foreign_key: { to_table: :users }
      t.belongs_to :to, null: false, foreign_key: { to_table: :users }
      t.text :body
      t.boolean :unread, default: true

      t.timestamps
    end
  end
end
