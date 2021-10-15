//
//  UIViewController+Ex.h
//  SWFrame
//
//  Created by 杨建祥 on 2021/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Ex)
@property(nullable, nonatomic, weak, readonly) UIViewController *qmui_previousViewController;

/**
 *  当前 viewController 是否是被以 present 的方式显示的，是则返回 YES，否则返回 NO
 *  @warning 对于被放在 UINavigationController 里显示的 UIViewController，如果 self 是 self.navigationController 的第一个 viewController，则如果 self.navigationController 是被 present 起来的，那么 self.qmui_isPresented = self.navigationController.qmui_isPresented = YES。利用这个特性，可以方便地给 navigationController 的第一个界面的左上角添加关闭按钮。
 */
- (BOOL)qmui_isPresented;

@end

NS_ASSUME_NONNULL_END
