module Refinery
  module VimeoVideos
    include ActiveSupport::Configurable
    config_accessor :vimeo_user_id
  end
end