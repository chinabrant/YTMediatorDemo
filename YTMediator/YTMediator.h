//
//  YTMediator.h
//  YTMediatorDemo
//
//  Created by brant on 2017/7/25.
//  Copyright © 2017年 lhtc-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^YTMediatorHandler) (NSDictionary *routerParameters);
typedef id (^YTMediatorObjectHandler) (NSDictionary *routerParameters);

typedef void (^YTMediatorCompletionHandler) (id result);

// 拿完成block的key
extern NSString *const YTMediatorParameterCompletionKey;

@interface YTMediator : NSObject

//@property (nonatomic, strong) id <UIApplicationDelegate> appDelegate;

+ (YTMediator *)shareInstance;

+ (void)registerURL:(NSString *)url;

+ (void)setup:(id<UIApplicationDelegate>)appDelegate;

// 打开一个url
+ (void)openURL:(NSString *)url;

+ (void)openURL:(NSString *)url completion:(YTMediatorCompletionHandler)completion;

/**
 获取当前的 view controller
 */
+ (UIViewController *)currentViewController;

// 注册一个url
+ (void)registerRouter:(NSString *)url handler:(YTMediatorHandler)handler;

// 注册一个对象url 调用这个url会返回一个object
+ (void)registerRouter:(NSString *)url objectHandler:(YTMediatorObjectHandler)handler;

@end
