//
//  SecondViewController.m
//  YTMediatorDemo
//
//  Created by brant on 2017/7/25.
//  Copyright © 2017年 lhtc-mac. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"2222";
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.handler) {
        self.handler(@{ @"key" : @"push返回的参数" });
    }
}

@end
