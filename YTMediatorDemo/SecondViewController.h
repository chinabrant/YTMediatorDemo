//
//  SecondViewController.h
//  YTMediatorDemo
//
//  Created by brant on 2017/7/25.
//  Copyright © 2017年 lhtc-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTMediator.h"

@interface SecondViewController : UIViewController

@property (nonatomic, copy) void (^handler)(id result); // handler;

@end
