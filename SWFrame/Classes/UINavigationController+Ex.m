//
//  UINavigationController+Ex.m
//  SWFrame
//
//  Created by 杨建祥 on 2021/10/15.
//

#import "UINavigationController+Ex.h"

@implementation UINavigationController (Ex)
- (nullable UIViewController *)qmui_rootViewController {
    return self.viewControllers.firstObject;
}

@end
