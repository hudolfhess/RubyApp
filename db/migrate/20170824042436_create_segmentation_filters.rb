class CreateSegmentationFilters < ActiveRecord::Migration[5.1]
  def change
    create_table :segmentation_filters do |t|
      t.references :segmentation, foreign_key: true
      t.integer :group
      t.string :field
      t.string :operation
      t.string :value

      t.timestamps
    end
  end
end
