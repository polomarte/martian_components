class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.column :type, :string
      t.column :kind, :string
      t.column :title, :string
      t.column :description, :text
      t.column :date, :date
      t.column :active, :boolean, default: false
      t.column :file, :string
      t.column :imageable_id, :integer
      t.column :imageable_type, :string
      t.column :position, :integer

      t.timestamps
    end

    Image.create_translation_table!({
      title: :string,
      description: :text})
  end

  def down
    drop_table :images
    Image.drop_translation_table!
  end
end
