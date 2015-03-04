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

@implementation HCSStarRatingView {
    NSUInteger _minimumValue;
    NSUInteger _maximumValue;
    CGFloat _value;
    NSUInteger _previousValue;
}

@dynamic minimumValue;
@dynamic maximumValue;
@dynamic value;

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
    self.backgroundColor = [UIColor clearColor];
    self.exclusiveTouch = YES;
    _minimumValue = 1;
    _maximumValue = 5;
    _value = 0;
    _spacing = 5.f;
}

#pragma mark - Properties

- (NSUInteger)minimumValue {
    return MAX(_minimumValue, 0);
}

- (void)setMinimumValue:(NSUInteger)minimumValue {
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
    if (_value != value) {
        _value = value;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        [self setNeedsDisplay];
    }
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

#pragma mark - Drawing

- (void)_drawStarWithFrame:(CGRect)frame tintColor:(UIColor*)tintColor highlighted:(BOOL)highlighted {
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
    
    if (highlighted) {
        [tintColor setFill];
        [starShapePath fill];
    }
    
    [tintColor setStroke];
    starShapePath.lineWidth = 1;
    [starShapePath stroke];
}

- (void)_drawHalfStarWithFrame:(CGRect)frame tintcolor:(UIColor *)tintColor highlighted:(BOOL)highlighted {
    UIBezierPath* starShapePath = UIBezierPath.bezierPath;
    [starShapePath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02500 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37292 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37309 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39112 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30504 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62908 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20642 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97500 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78265 * CGRectGetHeight(frame))];
    [starShapePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02500 * CGRectGetHeight(frame))];
    [starShapePath closePath];
    starShapePath.miterLimit = 4;
    
    if (highlighted) {
        [tintColor setFill];
        [starShapePath fill];
    }
    
    [tintColor setStroke];
    starShapePath.lineWidth = 1;
    [starShapePath stroke];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    CGFloat availableWidth = rect.size.width - (_spacing * (_maximumValue + 1));
    CGFloat cellWidth = (availableWidth / _maximumValue);
    CGFloat starSide = (cellWidth <= rect.size.height) ? cellWidth : rect.size.height;
    for (int idx = 0; idx < _maximumValue; idx++) {
        CGPoint center = CGPointMake(cellWidth*idx + cellWidth/2 + _spacing*(idx+1), rect.size.height/2);
        CGRect frame = CGRectMake(center.x - starSide/2, center.y - starSide/2, starSide, starSide);
        BOOL highlighted = (idx+1 <= ceilf(_value));
        BOOL halfStar = highlighted ? (idx+1 > _value) : NO;
        if (halfStar && _allowsHalfStars) {
            [self _drawStarWithFrame:frame tintColor:self.tintColor highlighted:NO];
            [self _drawHalfStarWithFrame:frame tintcolor:self.tintColor highlighted:highlighted];
        } else {
            [self _drawStarWithFrame:frame tintColor:self.tintColor highlighted:highlighted];
        }
    }
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}

#pragma mark - Touches

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
    _previousValue = _value;
    [self _handleTouch:touch];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    [self _handleTouch:touch];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    if ([self isFirstResponder]) {
        [self resignFirstResponder];
    }
    [self _handleTouch:touch];
    if (_value != _previousValue) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    if ([self isFirstResponder]) {
        [self resignFirstResponder];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return !self.isUserInteractionEnabled;
}

- (void)_handleTouch:(UITouch *)touch {
    CGFloat cellWidth = self.bounds.size.width / _maximumValue;
    CGPoint location = [touch locationInView:self];
    CGFloat value = location.x / cellWidth;
    if (_allowsHalfStars && value+.5f < ceilf(value)) {
        _value = floor(value)+.5f;
    } else {
        _value = ceilf(value);
    }
    [self setNeedsDisplay];
}

#pragma mark - First responder

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Intrinsic Content Size

- (CGSize)intrinsicContentSize {
    CGFloat height = 44.f;
    return CGSizeMake(_maximumValue * height + (_maximumValue+1) * _spacing, height);
}

@end
