class AddAttachable < ActiveRecord::Migration

  def self.up
    add_column :vimeo_videos, :attachable_type, :string
    add_column :vimeo_videos, :attachable_id, :integer
  end

  def self.down
    remove_column :vimeo_videos, :attachable_id
    remove_column :vimeo_videos, :attachable_type
  end

end