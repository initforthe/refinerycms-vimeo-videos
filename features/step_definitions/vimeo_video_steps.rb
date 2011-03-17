Given /^I have no vimeo_videos$/ do
  VimeoVideo.delete_all
end

Given /^I (only )?have vimeo_videos titled "?([^\"]*)"?$/ do |only, titles|
  VimeoVideo.delete_all if only
  titles.split(', ').each do |title|
    VimeoVideo.create(:title => title)
  end
end

Then /^I should have ([0-9]+) vimeo_videos?$/ do |count|
  VimeoVideo.count.should == count.to_i
end
