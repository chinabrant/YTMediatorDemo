//
//  YTMediator.m
//  YTMediatorDemo
//
//  Created by brant on 2017/7/25.
//  Copyright © 2017年 lhtc-mac. All rights reserved.
//

#import "YTMediator.h"
#import "MGJRouter.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NSString *const YTMediatorParameterCompletionKey = @"MGJRouterParameterCompletion";

@implementation YTMediator

+ (YTMediator *)shareInstance {
    static YTMediator *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

+ (void)setup:(id<UIApplicationDelegate>)appDelegate {
    [MGJRouter registerURLPattern:@"ytmediator://appDelegate" toObjectHandler:^id(NSDictionary *routerParameters) {
        return appDelegate.window.rootViewController;
    }];
}

// 注册一个url
+ (void)registerRouter:(NSString *)url handler:(YTMediatorHandler)handler {
    [MGJRouter registerURLPattern:url toHandler:^(NSDictionary *routerParameters) {
        handler(routerParameters);
    }];
}

// 注册一个对象url 调用这个url会返回一个object
+ (void)registerRouter:(NSString *)url objectHandler:(YTMediatorObjectHandler)handler {
    [MGJRouter registerURLPattern:url toObjectHandler:^id(NSDictionary *routerParameters) {
        return handler(routerParameters);
    }];
}

+ (void)openURL:(NSString *)url {
    [MGJRouter openURL:url];
}

+ (void)openURL:(NSString *)url completion:(YTMediatorCompletionHandler)completion {
    [MGJRouter openURL:url completion:^(id result) {
        completion(result);
    }];
}

+ (void)registerURL:(NSString *)url {
    [MGJRouter registerURLPattern:url toHandler:^(NSDictionary *routerParameters) {
        
        // 得处理controller不存在的情况
        // 取得vc实例
        UIViewController *vc = [[NSClassFromString(routerParameters[@"controller"]) alloc] init];
        // 将参数设置进去
        [YTMediator setViewController:vc param:routerParameters];
        
        if (routerParameters[@"present"]) {
            
            // present
            [[YTMediator currentViewController] presentViewController:vc animated:YES completion:nil];
            
        }
        else {
            
            // push
            [[YTMediator currentViewController].navigationController pushViewController:vc animated:YES];
            
        }
    }];
}

+ (UIViewController *)currentViewController {
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [MGJRouter objectForURL:@"ytmediator://appDelegate"];
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    return currVC;
}

// 把参数设置到vc的实例中
+ (void)setViewController:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters {
    // runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}

@end
