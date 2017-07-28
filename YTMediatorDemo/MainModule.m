//
//  MainModule.m
//  YTMediatorDemo
//
//  Created by brant on 2017/7/26.
//  Copyright © 2017年 lhtc-mac. All rights reserved.
//

#import "MainModule.h"
#import "YTMediator.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation MainModule

+ (void)load {
    [MainModule registerModule];
}

+ (void)registerModule {
    [YTMediator registerRouter:@"ytmediator://test/first" handler:^(NSDictionary *routerParameters) {
        FirstViewController *first = [[FirstViewController alloc] init];
        first.name = routerParameters[@"name"];
        [[YTMediator currentViewController].navigationController pushViewController:first animated:YES];
    }];
    
    [YTMediator registerRouter:@"ytmediator://test/second" handler:^(NSDictionary *routerParameters) {
        SecondViewController *second = [[SecondViewController alloc] init];
//        [[YTMediator currentViewController] presentViewController:second animated:YES completion:nil];
        
        second.handler = routerParameters[YTMediatorParameterCompletionKey];
        
        [[YTMediator currentViewController].navigationController pushViewController:second animated:YES];
    }];
}

@end
