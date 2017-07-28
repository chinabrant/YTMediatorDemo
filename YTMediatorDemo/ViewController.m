//
//  ViewController.m
//  YTMediatorDemo
//
//  Created by brant on 2017/7/25.
//  Copyright © 2017年 lhtc-mac. All rights reserved.
//

#import "ViewController.h"
#import "YTMediator.h"
#import "MGJRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)push:(id)sender {
    
    [YTMediator openURL:@"ytmediator://module1/main"];
    
    
}

- (IBAction)present:(id)sender {
    
    [YTMediator openURL:@"ytmediator://module2/main"];
}

- (IBAction)three:(id)sender {
    [YTMediator openURL:@"ytmediator://test/first?name=这是传的"];
}

// 返回值测试
- (IBAction)four:(id)sender {
    [YTMediator openURL:@"ytmediator://test/second" completion:^(id result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"返回参数" message:[NSString stringWithFormat:@"%@", result] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    }];
}

@end
