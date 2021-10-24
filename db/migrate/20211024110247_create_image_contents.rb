class CreateImageContents < ActiveRecord::Migration[6.1]
  def change
    create_table :image_contents do |t|

      t.timestamps
    end
  end
end
