Pod::Spec.new do |s|
  s.name         = "SCLAlertView"
  s.version      = "0.1"
  s.summary      = "Simple star rating view for iOS written in Objective-C"
  s.homepage     = "https://github.com/hugocampossousa/HCSStarRatingView"
  s.license      = { :type => "MIT", :file => "LICENCE" }
  s.author             = { "Hugo" => "hsousa@me.com" }
  s.social_media_url   = "http://twitter.com/hsousa"
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.source       = { :git => "git@github.com:hugocampossousa/HCSStarRatingView.git", :branch => "master" }
  s.source_files  = "HCSStarRatingView/*"
  s.requires_arc = true
end
