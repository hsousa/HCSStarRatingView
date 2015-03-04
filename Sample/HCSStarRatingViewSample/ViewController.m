//
//  ViewController.m
//  HCSStarRatingViewSample
//
//  Created by Hugo Sousa on 10/02/15.
//  Copyright (c) 2015 Hugo Sousa. All rights reserved.
//

#import "ViewController.h"
#import "HCSStarRatingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    starRatingView.maximumValue = 10;
    starRatingView.minimumValue = 0;
    starRatingView.value = 4.5f;
    starRatingView.tintColor = [UIColor redColor];
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:starRatingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
}

@end
