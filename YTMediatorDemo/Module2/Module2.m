//
//  Module2.m
//  YTMediatorDemo
//
//  Created by brant on 2017/7/26.
//  Copyright © 2017年 lhtc-mac. All rights reserved.
//

#import "Module2.h"
#import "YTMediator.h"
#import "Modules2ViewController.h"

@implementation Module2

+ (void)load {
    [Module2 registerModule];
}

+ (void)registerModule {
    
    // 注册url
    [YTMediator registerRouter:@"ytmediator://module2/main" handler:^(NSDictionary *routerParameters) {
        Modules2ViewController *vc = [[Modules2ViewController alloc] init];
        [[YTMediator currentViewController].navigationController pushViewController:vc animated:YES];
    }];
}

@end
