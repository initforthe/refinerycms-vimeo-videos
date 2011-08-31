# This model acts as a wrapper for uploaded videos only
# Everything else happens directly with the advanced vimeo api

module Refinery
  class VimeoVideo < ActiveRecord::Base
  
    # What is the max resource size a user can upload
    MAX_SIZE_IN_MB = 1000
  
    # when a dialog pops up with resources, how many resources per page should there be
    PAGES_PER_DIALOG = 18

    # when listing resources out in the admin area, how many resources should show per page
    PAGES_PER_ADMIN_INDEX = 20
  
    class << self
      # How many resources per page should be displayed?
      def per_page(dialog = false)
        dialog ? PAGES_PER_DIALOG : PAGES_PER_ADMIN_INDEX
      end
    end
  end
end