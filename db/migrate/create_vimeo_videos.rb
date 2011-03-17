class CreateVimeoVideos < ActiveRecord::Migration

  def self.up
    create_table :vimeo_videos do |t|
      t.string :vimeo_video_uid
      t.string :vimeo_video_name
      t.integer :position

      t.timestamps
    end

    add_index :vimeo_videos, :id

    load(Rails.root.join('db', 'seeds', 'vimeo_videos.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "vimeo_videos"})

    Page.delete_all({:link_url => "/vimeo_videos"})

    drop_table :vimeo_videos
  end

end
