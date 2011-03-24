(function($){
  $.fn.vimeo = function(options) {		
		return this.each(function() {
		  var $this = $(this);
		  
		  var options = options || new Array();
		  
		  var fieldname = options["fieldname"] || 'vimeo_video_uid';
		  var fieldname_plural = fieldname+'s';
		  var model = options["model"] || 'project';
		  var association = options["association"] || 'vimeo_videos';
		  var destroy_attr = "data-destroy-" + fieldname_plural.replace("_", "-");
		  var uid = "data-" + fieldname.replace("_", "-");
      
      $this.click(function(e) {
        var vimeo_video_uid = $this.attr(uid);
        var form_obj = $('#'+fieldname_plural).find('input[value="'+ vimeo_video_uid +'"]');
        var destroy_obj = $('#'+fieldname_plural).find('input['+ destroy_attr +'="'+ vimeo_video_uid +'"]');
        
		    if ($this.hasClass('activated'))
		    {
		      $this.removeClass('activated');
		      (destroy_obj.val() == 0) ? destroy_obj.val(1) : form_obj.remove();
		    }
		    else
		    {
		      var new_uid = new Date().getTime();
		      $this.addClass('activated');
		      (destroy_obj.val() == 1) ? destroy_obj.val(0) : $('#'+fieldname_plural).append('<input name="'+ model +'['+ association +'_attributes]['+ new_uid +']['+ fieldname +']" type="hidden" value="'+ vimeo_video_uid +'" />');		      
	      }
		    
		    e.preventDefault();
		  });
		});
  }
})(jQuery);