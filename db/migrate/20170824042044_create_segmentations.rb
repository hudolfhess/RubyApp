class CreateSegmentations < ActiveRecord::Migration[5.1]
  def change
    create_table :segmentations do |t|
      t.string :name

      t.timestamps
    end
  end
end
