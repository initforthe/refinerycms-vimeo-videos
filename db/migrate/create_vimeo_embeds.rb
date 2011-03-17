class CreateVimeoEmbeds < ActiveRecord::Migration

  def self.up
    create_table :vimeo_embeds do |t|
      t.integer :vimeo_id
      t.string :code
      t.string :options
      t.timestamps
    end
    
    add_index :vimeo_embeds, [:vimeo_id, :options]
  end

  def self.down
    drop_table :vimeo_embeds
  end

end