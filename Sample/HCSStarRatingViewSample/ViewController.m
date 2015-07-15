//
//  ViewController.m
//  HCSStarRatingViewSample
//
//  Created by Hugo Sousa on 10/02/15.
//  Copyright (c) 2015 Hugo Sousa. All rights reserved.
//

#import "ViewController.h"
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UILabel *lastRatingTitleLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HCSStarRatingView *starRatingView = [HCSStarRatingView new];
    starRatingView.maximumValue = 10;
    starRatingView.minimumValue = 0;
    starRatingView.value = 4;
    starRatingView.tintColor = [UIColor redColor];
    starRatingView.allowsHalfStars = YES;
    starRatingView.emptyStarImage = [[UIImage imageNamed:@"heart-empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    starRatingView.filledStarImage = [[UIImage imageNamed:@"heart-full"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:starRatingView];
    
    // auto layout
    starRatingView.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:starRatingView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.lastRatingTitleLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.f
                                  constant:8.f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:starRatingView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.f
                                   constant:0.f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:starRatingView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:.9f
                                   constant:0.f] setActive:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
}

@end
