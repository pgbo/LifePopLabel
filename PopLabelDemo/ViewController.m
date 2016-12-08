//
//  ViewController.m
//  PopLabelDemo
//
//  Created by guangbool on 2016/12/8.
//  Copyright © 2016年 guangbool. All rights reserved.
//

#import "ViewController.h"
#import "LifePopLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    LifePopLabel *popLabel = [[LifePopLabel alloc]initWithText:@"This method appends a cubic Bézier curve from the current point to the end point specified by the endPoint parameter. The two control points define the curvature of the segment. Figure 2 shows an approximation of a cubic Bézier curve given a set of initial points."];
    popLabel.textColor = [UIColor whiteColor];
    popLabel.fillColor = [UIColor orangeColor];
    popLabel.borderWidth = 0;
    popLabel.maxWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 30.f;
    popLabel.numbersOfLine = 0;
    popLabel.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:popLabel];
    popLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:popLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:popLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
