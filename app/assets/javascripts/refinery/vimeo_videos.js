var vimeo_video_dialog = {
  initialised: false
  , callback: null

  , init: function(callback){
    this.callback = callback;
    this.init_tabs();
    this.init_select();
    this.init_actions();
    this.initialised = true;
    return this;
  }

  , init_tabs: function(){
    var radios = $('#dialog_menu_left input:radio');
    var selected = radios.parent().filter(".selected_radio").find('input:radio').first() || radios.first();

    radios.click(function(){
      link_dialog.switch_area($(this));
    });

    selected.attr('checked', 'true');
    link_dialog.switch_area(selected);
  }

  , switch_area: function(radio){
    $('#dialog_menu_left .selected_radio').removeClass('selected_radio');
    $(radio).parent().addClass('selected_radio');
    $('#dialog_main .dialog_area').hide();
    $('#' + radio.value + '_area').show();
  }

  , init_select: function(){
    $('#existing_vimeo_video_area_content ul li img').click(function(){
        vimeo_video_dialog.set_vimeo_video(this);
    });
    //Select any currently selected, just uploaded...
    if ((selected_img = $('#existing_vimeo_video_area_content ul li.selected img')).length > 0) {
      vimeo_video_dialog.set_vimeo_video(selected_img.first());
    }
  }

  , set_vimeo_video: function(img){
    if ($(img).length > 0) {
      $('#existing_vimeo_video_area_content ul li.selected').removeClass('selected');

      $(img).parent().addClass('selected');
      var vimeo_videoId = $(img).attr('data-id');
      var geometry = $('#existing_vimeo_video_size_area li.selected a').attr('data-geometry');
      var size = $('#existing_vimeo_video_size_area li.selected a').attr('data-size');
      vimeo_video_url = $(img).attr('data-original');

      if (parent) {
        if ((wym_src = parent.document.getElementById('wym_src')) != null) {
          wym_src.value = vimeo_video_url;
        }
        if ((wym_title = parent.document.getElementById('wym_title')) != null) {
          wym_title.value = $(img).attr('title');
        }
        if ((wym_alt = parent.document.getElementById('wym_alt')) != null) {
          wym_alt.value = $(img).attr('alt');
        }
      }
    }
  }

  , submit_vimeo_video_choice: function(e) {
    e.preventDefault();
    if((img_selected = $('#existing_vimeo_video_area_content ul li.selected img').get(0)) && $.isFunction(this.callback))
    {
      this.callback(img_selected);
    }

    close_dialog(e);
  }

  , init_actions: function(){
    var _this = this;
    // get submit buttons not inside a wymeditor iframe
    $('#existing_vimeo_video_area .form-actions-dialog #submit_button')
      .not('.wym_iframe_body #existing_vimeo_video_area .form-actions-dialog #submit_button')
      .click($.proxy(_this.submit_vimeo_video_choice, _this));

    // get cancel buttons not inside a wymeditor iframe
    $('.form-actions-dialog #cancel_button')
      .not('.wym_iframe_body .form-actions-dialog #cancel_button')
      .click($.proxy(close_dialog, _this));

    $('#existing_vimeo_video_size_area ul li a').click(function(e) {
      $('#existing_vimeo_video_size_area ul li').removeClass('selected');
      $(this).parent().addClass('selected');
      $('#existing_vimeo_video_size_area #wants_to_resize_vimeo_video').attr('checked', 'checked');
      vimeo_video_dialog.set_vimeo_video($('#existing_vimeo_video_area_content ul li.selected img'));
      e.preventDefault();
    });

    $('#existing_vimeo_video_size_area #wants_to_resize_vimeo_video').change(function(){
      if($(this).is(":checked")) {
        $('#existing_vimeo_video_size_area ul li:first a').click();
      } else {
        $('#existing_vimeo_video_size_area ul li').removeClass('selected');
        vimeo_video_dialog.set_vimeo_video($('#existing_vimeo_video_area_content ul li.selected img'));
      }
    });

    vimeo_video_area = $('#existing_vimeo_video_area').not('#wym_iframe_body #existing_vimeo_video_area');
    vimeo_video_area.find('.form-actions input#submit_button').click($.proxy(function(e) {
      e.preventDefault();
      $(this.document.getElementById('wym_dialog_submit')).click();
    }, parent));
    vimeo_video_area.find('.form-actions a.close_dialog').click(close_dialog);
  }
};


var vimeo_video_picker = {
  initialised: false
  , options: {
    selected: ''
    , thumbnail: 'medium'
    , field: '#vimeo_video'
    , vimeo_video_display: '.current_picked_vimeo_video'
    , no_vimeo_video_message: '.no_picked_vimeo_video_selected'
    , vimeo_video_container: '.current_vimeo_video_container'
    , remove_vimeo_video_button: '.remove_picked_vimeo_video'
    , picker_container: '.vimeo_video_picker_container'
    , vimeo_video_link: '.current_vimeo_video_link'
    , vimeo_video_toggler: null
  }

  , init: function(new_options){
    this.options = $.extend(this.options, new_options);
    $(this.options.picker_container).find(this.options.remove_vimeo_video_button)
      .click($.proxy(this.remove_vimeo_video, {container: this.options.picker_container, picker: this}));
    $(this.options.picker_container).find(this.options.vimeo_video_toggler)
      .click($.proxy(this.toggle_vimeo_video, {container: this.options.picker_container, picker: this}));

    this.initialised = true;

    return this;
  }

  , remove_vimeo_video: function(e) {
    e.preventDefault();

    $(this.container).find(this.picker.options.vimeo_video_display)
      .removeClass('brown_border')
      .attr({'src': '', 'width': '', 'height': ''})
      .css({'width': 'auto', 'height': 'auto'})
      .hide();
    $(this.container).find(this.picker.options.field).val('');
    $(this.container).find(this.picker.options.no_vimeo_video_message).show();
    $(this.container).find(this.picker.options.remove_vimeo_video_button).hide();
    $(this).hide();
  }

  , toggle_vimeo_video: function(e) {
    $(this.container).find(this.options.vimeo_video_toggler).html(
      ($(this.container).find(options.vimeo_video_toggler).html() == 'Show' ? 'Hide' : 'Show')
    );
    $(this.container).find(this.options.vimeo_video_container).toggle();
    e.preventDefault();
  }

  , changed: function(e) {
    $(this.container).find(this.picker.options.field).val(
      this.vimeo_video.id.replace("vimeo_video_", "")
    );

    current_vimeo_video = $(this.container).find(this.picker.options.vimeo_video_display);
    current_vimeo_video.replaceWith(
      $("<img src='"+$(this.vimeo_video).attr('data-image')+"?"+Math.floor(Math.random() * 100000)+"' id='"+current_vimeo_video.attr('id')+"' class='"+this.picker.options.vimeo_video_display.replace(/^./, '')+" brown_border' />")
    );

    $(this.container).find(this.picker.options.remove_vimeo_video_button).show();
    $(this.container).find(this.picker.options.no_vimeo_video_message).hide();
  }
};