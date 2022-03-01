//
//  SWHelper.m
//  SWFrame
//
//  Created by liaoya on 2021/4/19.
//

#import "SWHelper.h"
#import <QMUIKit/QMUIKit.h>

@interface SWHelper ()

@end

@implementation SWHelper

- (CGFloat)toolBarHeight {
    return ToolBarHeight;
}

- (CGFloat)tabBarHeight {
    return TabBarHeight;
}

- (CGFloat)statusBarHeight {
    return StatusBarHeight;
}

- (CGFloat)statusBarHeightConstant {
    return StatusBarHeightConstant;
}

- (CGFloat)navigationBarHeight {
    return NavigationBarHeight;
}

- (CGFloat)navigationContentTop {
    return NavigationContentTop;
}

- (CGFloat)navigationContentTopConstant {
    return NavigationContentTopConstant;
}

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

@end
