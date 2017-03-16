class CreateComponents < ActiveRecord::Migration
  def up
    create_table :components do |t|
      t.column :type, :string
      t.column :key, :string, unique: true
      t.column :title, :string
      t.column :h1, :string
      t.column :h2, :string
      t.column :text, :text
      t.column :data, :text
      t.column :affix_nav_navegable, :boolean, default: false
      t.column :file, :string
      t.column :link_url, :string
      t.column :link_label, :string
      t.column :parent_id, :integer
      t.column :position, :integer
      t.column :published, :boolean, default: false

      t.timestamps
    end
    Component.create_translation_table!({
      title: :string,
      h1: :string,
      h2: :string,
      text: :text
    })
  end

  def down
    drop_table :components
    Component.drop_translation_table!
  end
end
