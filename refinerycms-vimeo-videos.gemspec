# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "refinery/vimeo-videos/version"

Gem::Specification.new do |s|
  s.name              = %q{refinerycms-vimeo-videos}
  s.version           = Refinery::VimeoVideos::VERSION
  s.description       = 'Ruby on Rails Vimeo Videos engine for Refinery CMS'
  s.summary           = 'Vimeo Videos engine for Refinery CMS'
  s.email             = %q{mail@bitflut.com}
  s.homepage          = %q{http://bitflut.com}
  s.authors           = ['Marian Andre']
  s.license           = %q{MIT}
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency    'vimeo', '~> 1.4'
  s.add_development_dependency    'fakeweb', '~> 1.2.6'
  
end