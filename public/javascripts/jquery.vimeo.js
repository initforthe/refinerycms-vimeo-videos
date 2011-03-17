(function($){
  $.fn.vimeo = function(options) {		
		return this.each(function() {
		  var $this = $(this);
      $this.click(function(e) {
        var vimeo_video_uid = $this.attr("data-vimeo-video-uid");
        var form_obj = $('#vimeo_video_uids').find('input[value="'+ vimeo_video_uid +'"]');
        var destroy_obj = $('#vimeo_video_uids').find('input[data-destroy-vimeo-video-uid="'+ vimeo_video_uid +'"]');
        
		    if ($this.hasClass('activated'))
		    {
		      $this.removeClass('activated');
		      (destroy_obj.val() == 0) ? destroy_obj.val(1) : form_obj.remove();
		    }
		    else
		    {
		      var new_uid = new Date().getTime();
		      $this.addClass('activated');
		      (destroy_obj.val() == 1) ? destroy_obj.val(0) : $('#vimeo_video_uids').append('<input name="project[vimeo_videos_attributes]['+ new_uid +'][vimeo_video_uid]" type="hidden" value="'+ vimeo_video_uid +'" />');		      
	      }
		    
		    e.preventDefault();
		  });
		});
  }
})(jQuery);