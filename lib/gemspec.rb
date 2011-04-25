#!/usr/bin/env ruby
require 'pathname'
gempath = Pathname.new(File.expand_path('../../', __FILE__))

$:.push File.expand_path("../lib", __FILE__)
require "refinerycms_vimeo_videos/version"

files = %w( Gemfile *.md **/**/{*,.rspec,.gitignore,.yardopts} ).map { |file| Pathname.glob(file) }.flatten
rejection_patterns = [
  "^public/system",
  "^config/(application|boot|environment).rb$",
  "^config/initializers(\/.*\.rb)?$",
  "^config/(database|i18n\-js).yml$",
  "^lib\/gemspec\.rb",
  ".*\/cache\/",
  "^script\/*",
  "^vendor\/plugins\/?$",
  "(^log|\.log)$",
  "\.rbc$",
  "^tmp(|/.+?)$",
  ".gem$",
  "^doc($|\/)"
]

files.reject! do |f|
  !f.exist? or (f.directory? and f.children.empty?) or f.to_s =~ %r{(#{rejection_patterns.join(')|(')})}
end

gemspec = <<EOF
# DO NOT EDIT THIS FILE DIRECTLY! Instead, use lib/gemspec.rb to generate it.
$:.push File.expand_path("../lib", __FILE__)
require "refinerycms_vimeo_videos/version"

Gem::Specification.new do |s|
  s.name              = %q{#{gemname = 'refinerycms-vimeo-videos'}}
  s.version           = %q{#{RefinerycmsVimeoVideos::VERSION}}
  s.description       = 'Ruby on Rails Vimeo Videos engine for Refinery CMS'
  s.date              = %q{#{Time.now.strftime('%Y-%m-%d')}}
  s.summary           = 'Vimeo Videos engine for Refinery CMS'
  s.email             = %q{mail@bitflut.com}
  s.homepage          = %q{http://bitflut.com}
  s.authors           = ['Marian Andre']
  s.license           = %q{MIT}
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*']
  
  s.add_dependency    'vimeo', '~> 1.3.0'
  s.add_dependency    'httparty', '~> 0.6.1'
  s.add_dependency    'fakeweb', '~> 1.2.6'
  
  s.files             = [
    '#{files.sort.join("',\n    '")}'
  ]
end
EOF


(gemfile = gempath.join("#{gemname}.gemspec")).open('w') {|f| f.puts(gemspec)}
puts `cd #{gempath} && gem build #{gemfile}` if ARGV.any?{|a| a == "BUILD=true"}
