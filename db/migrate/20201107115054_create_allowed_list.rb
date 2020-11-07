class CreateAllowedList < ActiveRecord::Migration[6.0]
  def change
    create_table :allowed_lists do |t|
      t.string :code, index: true, null: false

      t.timestamps
    end
  end
end
