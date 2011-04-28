Refinerycms-Vimeo-Videos
========================

This gem makes it easy for refinerycms sites to add vimeo videos to models. It is still in a very experimental phase of development, but already used in production. Use only if you are sure about what the code does.

Setup and Authorization
-----------------------

Add the gem to your Gemfile and bundle install it

    gem 'refinerycms-vimeo-videos'
    
Run the generator and migrate your database

    rails generate refinerycms_vimeo_videos
    rake db:migrate

Create an api-application for your vimeo account under http://vimeo.com/api/applications with a callback url of

    http://yourapp.com/refinery/vimeo_videos/callback

Copy/paste the consumer\_key and consumer\_secret of your vimeo api-application to the related Refinery Settings (:vimeo\_consumer\_key and :vimeo\_consumer\_secret). Then access the following url:

    http://yourapp.com/refinery/vimeo_videos/authorization
    
After this, your app should be setup to use your vimeo account.

Adding a vimeo video
--------------------

Add a field to the table:

    add_column :projects, :test_video_id, :string

Call _vimeo\_video_ in your model with the corresponding field as attribute:

    vimeo_video :test_video
    
In your _form.html.erb insert this:

    <div class='field'>
      <%= f.label "Test Video" -%>
      <%= render :partial => "/shared/admin/vimeo_picker", :locals => {
            :f => f,
            :field => :test_video_id,
            :vimeo_video => @project.test_video
          } %>
    </div>
    
Now embed the video (with a width of 750px):

    <%= @project.test_video.embed '750' -%>
    
Invalidating Caches
-------------------

If you need to invalidate the whole cache, simply call delete\_all on VimeoEmbedCache and VimeoMetaCache.

In case you want to just pull in changes, you can do:

    VimeoEmbedCache.update_cache
    VimeoMetaCache.update_cache

TODO
----

Alot!