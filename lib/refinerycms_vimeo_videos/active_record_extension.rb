module RefinerycmsVimeoVideos
  module ActiveRecordExtension
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      
      def vimeo_video field
        class_eval <<-EOV
        
          def #{field}
            if self.new_record?
              self.#{field}_id
            else
              self.#{field}_id? ? VimeoMetaCache.find_or_create_by_vid(self.#{field}_id) : nil
            end
          end
          
          before_save :cache_vimeo_meta_for_#{field}
          
          def cache_vimeo_meta_for_#{field}
            if self.#{field}_id? and self.#{field}_id_changed?
              VimeoMetaCache.find_or_create_by_vid(self.#{field}_id)
            end
          end
          protected :cache_vimeo_meta_for_#{field}
          
        EOV
      end
    
    end
        
  end
end

ActiveRecord::Base.class_eval { include RefinerycmsVimeoVideos::ActiveRecordExtension }