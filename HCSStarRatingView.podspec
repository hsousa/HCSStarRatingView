Pod::Spec.new do |s|
  s.name                  = "HCSStarRatingView"
  s.version               = "1.5"
  s.summary               = "Simple star rating view for iOS written in Objective-C"
  s.description           = "A UIControl subclass to easily provide users with a basic star-rating interface. It's fully accessible, supports all device resolutions and requires no images do render the stars, thanks to PaintCode. You can, however, provide your own custom images if you like."
  s.homepage              = "https://github.com/hsousa/HCSStarRatingView"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "Hugo" => "hsousa@me.com" }
  s.social_media_url      = "http://twitter.com/hsousa"
  s.platform              = :ios
  s.ios.deployment_target = '7.0'
  s.source                = { :git => "https://github.com/hsousa/HCSStarRatingView.git", :tag => "1.5" }
  s.source_files          = "HCSStarRatingView/*.{h,m}"
  s.requires_arc          = true
end
