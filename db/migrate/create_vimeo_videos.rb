class CreateVimeoVideos < ActiveRecord::Migration

  def self.up
    create_table :vimeo_videos do |t|
      t.strng :attachable_type
      t.integer :attachable_id
      t.string :vid, :unique => true
      
      t.string :cached_title
      t.text :cached_description
      t.integer :cached_image_id
      t.timestamp :cached_created_at

      t.timestamps
    end

    add_index :vimeo_videos, :id
    add_index :vimeo_videos, :vid

    load(Rails.root.join('db', 'seeds', 'vimeo_videos.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "vimeo_videos"})

    Page.delete_all({:link_url => "/vimeo_videos"})

    drop_table :vimeo_videos
  end

end
