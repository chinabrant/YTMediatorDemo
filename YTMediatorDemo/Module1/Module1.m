//
//  Module1.m
//  YTMediatorDemo
//
//  Created by brant on 2017/7/26.
//  Copyright © 2017年 lhtc-mac. All rights reserved.
//

#import "Module1.h"
#import "Module1ViewController.h"
#import "YTMediator.h"

@implementation Module1

+ (void)load {
    // load方法在加载类的时候会自动调用。所以可以做到模块的路由注册可以在模块内完成
    [Module1 registerModule];
}

+ (void)registerModule {
    
    // 注册url
    [YTMediator registerRouter:@"ytmediator://module1/main" handler:^(NSDictionary *routerParameters) {
        Module1ViewController *vc = [[Module1ViewController alloc] init];
        [[YTMediator currentViewController].navigationController pushViewController:vc animated:YES];
    }];
}

@end
