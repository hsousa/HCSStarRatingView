# HCSStarRatingView

`HCSStarRatingView` is a `UIControl` subclass to easily provide users with a basic star-rating interface.

<img src="https://raw.github.com/hugocampossousa/HCSStarRatingView/master/Assets/ios.gif" width="288" height="86	" />

## Usage

### Programatically

You can create a new rating view programatically by importing HCSStarRatingView.h and HCSStarRatingView.m into your project and:

```objective-c
#import "HCSStarRatingView.h"
```

```objective-c
HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
starRatingView.maximumValue = 10;
starRatingView.minimumValue = 0;
starRatingView.value = 0;
starRatingView.tintColor = [UIColor redColor];
[starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:starRatingView];
```

### Interface Builder

`HCSStarRatingView` also implements IB_DESIGNABLE and IBInspectable so you can fully customize it in Interface Builder.

<a href="https://raw.github.com/hugocampossousa/HCSStarRatingView/master/Assets/ib.png"><img src="https://raw.github.com/hugocampossousa/HCSStarRatingView/master/Assets/ib.png" width="320"/></a>

## Contact
Hugo Sousa
* [github.com/hugocampossousa](http://github.com/hugocampossousa)
* [twitter/hsousa](http://twitter.com/hsousa)
* [hsousa@me.com](hsousa@me.com)

## License
HCSStarRatingView is available under the MIT license. See the LICENSE file for more info.