// HCSStarRatingView.m
//
// Copyright (c) 2015 Hugo Sousa
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "HCSStarRatingView.h"

@interface HCSStarRatingView ()
@property (nonatomic, readonly) BOOL shouldUseImages;
@end

@implementation HCSStarRatingView {
    CGFloat _minimumValue;
    NSUInteger _maximumValue;
    CGFloat _value;
    UIColor *_starBorderColor;
}

@dynamic minimumValue;
@dynamic maximumValue;
@dynamic value;
@dynamic shouldUseImages;
@dynamic starBorderColor;

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _customInit];
    }
    return self;
}

- (void)_customInit {
    self.exclusiveTouch = YES;
    _minimumValue = 0;
    _maximumValue = 5;
    _value = 0;
    _spacing = 5.f;
    _continuous = YES;
    _starBorderWidth = 1.0f;
    _emptyStarColor = [UIColor clearColor];
    
    [self _updateAppearanceForState:self.enabled];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}

#pragma mark - Properties

- (UIColor *)backgroundColor {
    if ([super backgroundColor]) {
        return [super backgroundColor];
    } else {
        return self.isOpaque ? [UIColor whiteColor] : [UIColor clearColor];
    };
}

- (CGFloat)minimumValue {
    return MAX(_minimumValue, 0);
}

- (void)setMinimumValue:(CGFloat)minimumValue {
    if (_minimumValue != minimumValue) {
        _minimumValue = minimumValue;
        [self setNeedsDisplay];
    }
}

- (NSUInteger)maximumValue {
    return MAX(_minimumValue, _maximumValue);
}

- (void)setMaximumValue:(NSUInteger)maximumValue {
    if (_maximumValue != maximumValue) {
        _maximumValue = maximumValue;
        [self setNeedsDisplay];
        [self invalidateIntrinsicContentSize];
    }
}

- (CGFloat)value {
    return MIN(MAX(_value, _minimumValue), _maximumValue);
}

- (void)setValue:(CGFloat)value {
    [self setValue:value sendValueChangedAction:NO];
}

- (void)setValue:(CGFloat)value sendValueChangedAction:(BOOL)sendAction {
    [self willChangeValueForKey:NSStringFromSelector(@selector(value))];
    if (_value != value && value >= _minimumValue && value <= _maximumValue) {
        _value = value;
        if (sendAction) [self sendActionsForControlEvents:UIControlEventValueChanged];
        [self setNeedsDisplay];
    }
    [self didChangeValueForKey:NSStringFromSelector(@selector(value))];
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = MAX(spacing, 0);
    [self setNeedsDisplay];
}

- (void)setAllowsHalfStars:(BOOL)allowsHalfStars {
    if (_allowsHalfStars != allowsHalfStars) {
        _allowsHalfStars = allowsHalfStars;
        [self setNeedsDisplay];
    }
}

- (void)setAccurateHalfStars:(BOOL)accurateHalfStars {
    if (_accurateHalfStars != accurateHalfStars) {
        _accurateHalfStars = accurateHalfStars;
        [self setNeedsDisplay];
    }
}

- (void)setEmptyStarImage:(UIImage *)emptyStarImage {
    if (_emptyStarImage != emptyStarImage) {
        _emptyStarImage = emptyStarImage;
        [self setNeedsDisplay];
    }
}

- (void)setHalfStarImage:(UIImage *)halfStarImage {
    if (_halfStarImage != halfStarImage) {
        _halfStarImage = halfStarImage;
        [self setNeedsDisplay];
    }
}

- (void)setFilledStarImage:(UIImage *)filledStarImage {
    if (_filledStarImage != filledStarImage) {
        _filledStarImage = filledStarImage;
        [self setNeedsDisplay];
    }
}

- (void)setEmptyStarColor:(UIColor *)emptyStarColor {
    if (_emptyStarColor != emptyStarColor) {
        _emptyStarColor = emptyStarColor;
        [self setNeedsDisplay];
    }
}

- (void)setStarBorderColor:(UIColor *)starBorderColor {
    if (_starBorderColor != starBorderColor) {
        _starBorderColor = starBorderColor;
        [self setNeedsDisplay];
    }
}

- (UIColor *)starBorderColor {
    if (_starBorderColor == nil) {
        return self.tintColor;
    } else {
        return _starBorderColor;
    }
}

- (void)setStarBorderWidth:(CGFloat)starBorderWidth {
    _starBorderWidth = MAX(0, starBorderWidth);
    [self setNeedsDisplay];
}


- (BOOL)shouldUseImages {
    return (self.emptyStarImage!=nil && self.filledStarImage!=nil);
}

#pragma mark - State

- (void)setEnabled:(BOOL)enabled
{
    [self _updateAppearanceForState:enabled];
    [super setEnabled:enabled];
}

- (void)_updateAppearanceForState:(BOOL)enabled
{
    self.alpha = enabled ? 1.f : .5f;
}

#pragma mark - Image Drawing

- (void)_drawStarImageWithFrame:(CGRect)frame tintColor:(UIColor*)tintColor highlighted:(BOOL)highlighted {
    UIImage *image = highlighted ? self.filledStarImage : self.emptyStarImage;
    [self _drawImage:image frame:frame tintColor:tintColor];
}

- (void)_drawHalfStarImageWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor {
    [self _drawAccurateHalfStarImageWithFrame:frame tintColor:tintColor progress:.5f];
}

- (void)_drawAccurateHalfStarImageWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor progress:(CGFloat)progress {
    UIImage *image = self.halfStarImage;
    if (image == nil) {
        // first draw star outline
        [self _drawStarImageWithFrame:frame tintColor:tintColor highlighted:NO];
        
        image = self.filledStarImage;
        CGRect imageFrame = CGRectMake(0, 0, image.size.width * image.scale * progress, image.size.height * image.scale);
        frame.size.width *= progress;
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, imageFrame);
        UIImage *halfImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
        image = [halfImage imageWithRenderingMode:image.renderingMode];
        CGImageRelease(imageRef);
    }
    [self _drawImage:image frame:frame tintColor:tintColor];
}

- (void)_drawImage:(UIImage *)image frame:(CGRect)frame tintColor:(UIColor *)tintColor {
    if (image.renderingMode == UIImageRenderingModeAlwaysTemplate) {
        [tintColor setFill];
    }
    [image drawInRect:frame];
}

#pragma mark - Shape Drawing

- (void)_drawStarShapeWithFrame:(CGRect)frame tintColor:(UIColor*)tintColor highlighted:(BOOL)highlighted {
    [self _drawAccurateHalfStarShapeWithFrame:frame tintColor:tintColor progress:highlighted ? 1.f : 0.f];
}

- (void)_drawHalfStarShapeWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor {
    [self _drawAccurateHalfStarShapeWithFrame:frame tintColor:tintColor progress:.5f];
}

- (void)_drawAccurateHalfStarShapeWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor progress:(CGFloat)progress {
    UIBezierPath* starShapePath = UIBezierPath.bezierPath;
    [starShapePath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62723 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37309 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02500 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37292 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37309 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39112 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30504 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62908 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20642 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97500 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78265 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79358 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97500 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69501 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62908 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39112 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62723 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37309 * CGRectGetHeight(frame))];
    [starShapePath closePath];
    starShapePath.miterLimit = 4;
    
    CGFloat frameWidth = frame.size.width;
    CGRect rightRectOfStar = CGRectMake(frame.origin.x + progress * frameWidth, frame.origin.y, frameWidth - progress * frameWidth, frame.size.height);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectInfinite];
    [clipPath appendPath:[UIBezierPath bezierPathWithRect:rightRectOfStar]];
    clipPath.usesEvenOddFillRule = YES;
    
    [_emptyStarColor setFill];
    [starShapePath fill];
    
    CGContextSaveGState(UIGraphicsGetCurrentContext()); {
        [clipPath addClip];
        [tintColor setFill];
        [starShapePath fill];
    }
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
    
    [self.starBorderColor setStroke];
    starShapePath.lineWidth = _starBorderWidth;
    [starShapePath stroke];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    CGFloat availableWidth = rect.size.width - (_spacing * (_maximumValue - 1)) - 2;
    CGFloat cellWidth = (availableWidth / _maximumValue);
    CGFloat starSide = (cellWidth <= rect.size.height) ? cellWidth : rect.size.height;
    starSide = (self.shouldUseImages) ? starSide : (starSide - _starBorderWidth);
    
    for (int idx = 0; idx < _maximumValue; idx++) {
        CGPoint center = CGPointMake(cellWidth*idx + cellWidth/2 + _spacing*idx + 1, rect.size.height/2);
        CGRect frame = CGRectMake(center.x - starSide/2, center.y - starSide/2, starSide, starSide);
        BOOL highlighted = (idx+1 <= ceilf(_value));
        if (_allowsHalfStars && highlighted && (idx+1 > _value)) {
            if (_accurateHalfStars) {
                [self _drawAccurateStarWithFrame:frame tintColor:self.tintColor progress:_value - idx];
            }
            else {
                 [self _drawHalfStarWithFrame:frame tintColor:self.tintColor];
            }
        } else {
            [self _drawStarWithFrame:frame tintColor:self.tintColor highlighted:highlighted];
        }
    }
}

- (void)_drawStarWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor highlighted:(BOOL)highlighted {
    if (self.shouldUseImages) {
        [self _drawStarImageWithFrame:frame tintColor:tintColor highlighted:highlighted];
    } else {
        [self _drawStarShapeWithFrame:frame tintColor:tintColor highlighted:highlighted];
    }
}

- (void)_drawHalfStarWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor {
    if (self.shouldUseImages) {
        [self _drawHalfStarImageWithFrame:frame tintColor:tintColor];
    } else {
        [self _drawHalfStarShapeWithFrame:frame tintColor:tintColor];
    }
}
- (void)_drawAccurateStarWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor progress:(CGFloat)progress {
    if (self.shouldUseImages) {
        [self _drawAccurateHalfStarImageWithFrame:frame tintColor:tintColor progress:progress];
    } else {
        [self _drawAccurateHalfStarShapeWithFrame:frame tintColor:tintColor progress:progress];
    }
}
#pragma mark - Touches

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.isEnabled) {
        [super beginTrackingWithTouch:touch withEvent:event];
        if (_shouldBecomeFirstResponder && ![self isFirstResponder]) {
            [self becomeFirstResponder];
        }
        [self _handleTouch:touch];
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.isEnabled) {
        [super continueTrackingWithTouch:touch withEvent:event];
        [self _handleTouch:touch];
        return YES;
    } else {
        return NO;
    }
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    if (_shouldBecomeFirstResponder && [self isFirstResponder]) {
        [self resignFirstResponder];
    }
    [self _handleTouch:touch];
    if (!_continuous) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    if (_shouldBecomeFirstResponder && [self isFirstResponder]) {
        [self resignFirstResponder];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer.view isEqual:self]) {
        return !self.isUserInteractionEnabled;
    }
    return self.shouldBeginGestureRecognizerBlock ? self.shouldBeginGestureRecognizerBlock(gestureRecognizer) : NO;
}

- (void)_handleTouch:(UITouch *)touch {
    CGFloat cellWidth = self.bounds.size.width / _maximumValue;
    CGPoint location = [touch locationInView:self];
    CGFloat value = location.x / cellWidth;
    if (_allowsHalfStars) {
        if (_accurateHalfStars) {
            value = value;
        }
        else {
            if (value+.5f < ceilf(value)) {
                value = floor(value)+.5f;
            } else {
                value = ceilf(value);
            }
        }
    } else {
        value = ceilf(value);
    }
    [self setValue:value sendValueChangedAction:_continuous];
}

#pragma mark - First responder

- (BOOL)canBecomeFirstResponder {
    return _shouldBecomeFirstResponder;
}

#pragma mark - Intrinsic Content Size

- (CGSize)intrinsicContentSize {
    CGFloat height = 44.f;
    return CGSizeMake(_maximumValue * height + (_maximumValue-1) * _spacing, height);
}

#pragma mark - Accessibility

- (BOOL)isAccessibilityElement {
    return YES;
}

- (NSString *)accessibilityLabel {
    return [super accessibilityLabel] ?: NSLocalizedString(@"Rating", @"Accessibility label for star rating control.");
}

- (UIAccessibilityTraits)accessibilityTraits {
    return ([super accessibilityTraits] | UIAccessibilityTraitAdjustable);
}

- (NSString *)accessibilityValue {
    return [@(self.value) description];
}

- (BOOL)accessibilityActivate {
    return YES;
}

- (void)accessibilityIncrement {
    CGFloat value = self.value + (self.allowsHalfStars ? .5f : 1.f);
    [self setValue:value sendValueChangedAction:YES];
}

- (void)accessibilityDecrement {
    CGFloat value = self.value - (self.allowsHalfStars ? .5f : 1.f);
    [self setValue:value sendValueChangedAction:YES];
}

@end
