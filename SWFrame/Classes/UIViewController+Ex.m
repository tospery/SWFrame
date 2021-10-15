//
//  UIViewController+Ex.m
//  SWFrame
//
//  Created by 杨建祥 on 2021/10/15.
//

#import "UIViewController+Ex.h"
#import "UINavigationController+Ex.h"

@implementation UIViewController (Ex)
- (UIViewController *)qmui_previousViewController {
    NSArray<UIViewController *> *viewControllers = self.navigationController.viewControllers;
    NSUInteger index = [viewControllers indexOfObject:self];
    if (index != NSNotFound && index > 0) {
        return viewControllers[index - 1];
    }
    return nil;
}

- (BOOL)qmui_isPresented {
    UIViewController *viewController = self;
    if (self.navigationController) {
        if (self.navigationController.qmui_rootViewController != self) {
            return NO;
        }
        viewController = self.navigationController;
    }
    BOOL result = viewController.presentingViewController.presentedViewController == viewController;
    return result;
}

@end
