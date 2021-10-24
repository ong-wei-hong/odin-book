class CreateTextContents < ActiveRecord::Migration[6.1]
  def change
    create_table :text_contents do |t|
			t.text :text

      t.timestamps
    end
  end
end
