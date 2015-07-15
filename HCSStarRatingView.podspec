Pod::Spec.new do |s|
  s.name         = "HCSStarRatingView"
  s.version      = "1.2"
  s.summary      = "Simple star rating view for iOS written in Objective-C"
  s.description  = "A UIControl subclass to easily provide users with a basic star-rating interface. It supports all device resolutions and requires no images do render the stars, thanks to PaintCode."
  s.homepage     = "https://github.com/hugocampossousa/HCSStarRatingView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Hugo" => "hsousa@me.com" }
  s.social_media_url   = "http://twitter.com/hsousa"
  s.platform     = :ios
  s.ios.deployment_target = '7.0'
  s.source       = { :git => "git@github.com:hugocampossousa/HCSStarRatingView.git", :branch => "master" }
  s.source_files  = "HCSStarRatingView/*"
  s.requires_arc = true
end
