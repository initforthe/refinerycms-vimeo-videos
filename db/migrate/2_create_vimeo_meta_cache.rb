class CreateVimeoMetaCache < ActiveRecord::Migration

  def self.up
    create_table Refinery::VimeoMetaCache do |t|
      t.string :vid, :unique => true
      t.string :title
      t.text :description
      t.integer :image_id

      t.timestamps
    end

    add_index :refinery_vimeo_meta_cache, [:vid]
  end

  def self.down
    [::VimeoMetaCache].reject{|m|
      !(defined?(m) and m.respond_to?(:table_name))
    }.each do |model|
      drop_table model.table_name
    end
  end

end