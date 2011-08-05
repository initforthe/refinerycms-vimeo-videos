class CreateVimeoVideos < ActiveRecord::Migration

  def self.up
    create_table :vimeo_videos do |t|
      t.string :vid, :unique => true
      t.string :title
      t.text :description
      
      t.timestamps
    end

  end

  def self.down
    [::VimeoVideo].reject{|m|
      !(defined?(m) and m.respond_to?(:table_name))
    }.each do |model|
      drop_table model.table_name
    end
  end

end