# HCSStarRatingView

`HCSStarRatingView` is a `UIControl` subclass to easily provide users with a basic star rating interface.

It supports all device resolutions and although it requires no images to render the stars (thanks <a href="http://www.paintcodeapp.com" target=_blank>PaintCode</a>), you can provide custom ones if you so desire.

<img src="https://raw.github.com/hsousa/HCSStarRatingView/master/Assets/demo.gif" width="240" />

## Installation

### Carthage

```
github "hsousa/HCSStarRatingView"
```

### CocoaPods

```
use_frameworks!

(...)

pod 'HCSStarRatingView', '~> 1.5'
```

and run `pod install`

### Manually

You can also install it manually by copying `HCSStarRatingView.{h|m}` into your project or including the project in your own project/workspace, similar to what's being done in `Sample`.

## Usage

### Programatically

Create a new instance and set the properties you desire to customize.

```objective-c
HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
starRatingView.maximumValue = 10;
starRatingView.minimumValue = 0;
starRatingView.value = 0;
starRatingView.tintColor = [UIColor redColor];
[starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:starRatingView];
```

`HCSStarRatingView` also works great with Auto Layout, so feel free to set some constraints instead of just giving it a frame (check sample project)!

#### Half-star ratings:

```objective-c
starRatingView.allowsHalfStars = YES;
starRatingView.value = 2.5f;
```

Enable `accurateHalfStars` to get more precise ratings (works with images too)!
```objective-c
starRatingView.accurateHalfStars = YES;
```

#### Custom images:

Using custom images in `HCSStarRatingView` is as easy as setting a property. You only need to set `emptyStarImage` and `filledStarImage`, but you can also provide the half image to `halfStarImage`, if your design requires you to:

```objective-c
starRatingView.emptyStarImage = [UIImage imageNamed:@"heart-empty"];
starRatingView.halfStarImage = [UIImage imageNamed:@"heart-half"]; // optional
starRatingView.filledStarImage = [UIImage imageNamed:@"heart-full"];
```

If you want to use template images programatically, just make sure they have the proper `Rendering Mode`:

```objective-c
starRatingView.emptyStarImage = [[UIImage imageNamed:@"heart-empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
starRatingView.halfStarImage = [[UIImage imageNamed:@"heart-half"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]; // optional
starRatingView.filledStarImage = [[UIImage imageNamed:@"heart-full"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
```

### Interface Builder

`HCSStarRatingView` also implements `IB_DESIGNABLE` and `IBInspectable` so you can fully customize it in Interface Builder.

<img src="https://raw.github.com/hsousa/HCSStarRatingView/master/Assets/interface-builder.png"/>

PS: In order to use template images in Interface Builder you must go to that image's properties in your Asset Catalog and change the `Render As` setting to `Template Image`.

## Accessibility

Users with specific needs should be able to fully read and interact with `HCSStarRatingView`, since it fully supports VoiceOver.

If you or your users have other specific needs and you're having issues with this control, please contact me so we can figure it out! :-)

## Contact
Hugo Sousa
* [github.com/hsousa](http://github.com/hsousa)
* [twitter/hsousa](http://twitter.com/hsousa)
* [hsousa@me.com](hsousa@me.com)

## License
HCSStarRatingView is available under the MIT license. See the LICENSE file for more info.
