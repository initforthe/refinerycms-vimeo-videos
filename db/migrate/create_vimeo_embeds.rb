class CreateVimeoEmbeds < ActiveRecord::Migration

  def self.up
    create_table :vimeo_embeds do |t|
      t.integer :vid
      t.string :code
      t.text :configuration
      t.timestamps
    end
    
    add_index :vimeo_embeds, [:vid, :configuration]
  end

  def self.down
    drop_table :vimeo_embeds
  end

end