class CreateVimeoEmbedCache < ActiveRecord::Migration

  def self.up
    create_table Refinery::VimeoEmbedCache do |t|
      t.string :vid
      t.string :code
      t.text :configuration
      t.timestamps
    end
    
    add_index :refinery_vimeo_embed_cache, [:vid]
  end

  def self.down
    [::VimeoEmbedCache].reject{|m|
      !(defined?(m) and m.respond_to?(:table_name))
    }.each do |model|
      drop_table model.table_name
    end
  end

end