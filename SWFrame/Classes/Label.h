//
//  Label.h
//  iOSFrame
//
//  Created by liaoya on 2020/7/24.
//

//
//  Label.h
//  qmui
//
//  Created by QMUI Team on 14-7-3.
//

#import <UIKit/UIKit.h>

/**
 * `Label`支持通过`contentEdgeInsets`属性来实现类似padding的效果。
 *
 * 同时通过将`canPerformCopyAction`置为`YES`来开启长按复制文本的功能，复制 item 的文案可通过 menuItemTitleForCopyAction 修改，长按时label的背景色默认为`highlightedBackgroundColor`
 */
@interface Label : UILabel

/// 控制label内容的padding，默认为UIEdgeInsetsZero
@property(nonatomic,assign) UIEdgeInsets contentEdgeInsets;

/// 是否需要长按复制的功能，默认为 NO。
/// 长按时的背景色通过`highlightedBackgroundColor`设置。
@property(nonatomic,assign) IBInspectable BOOL canPerformCopyAction;

/// 当 canPerformCopyAction 开启时，长按出来的菜单上的复制按钮的文本，默认为 nil，nil 时 menuItem 上的文字为“复制”
@property(nonatomic, copy) IBInspectable NSString *menuItemTitleForCopyAction;

/**
 label 在 highlighted 时的背景色，通常用于两种场景：
 1. 开启了 canPerformCopyAction 时，长按后的背景色
 2. 作为 subviews 放在 UITableViewCell 上，当 cell highlighted 时，label 也会触发 highlighted，此时背景色也会显示为这个属性的值
 
 默认为 nil
*/
@property(nonatomic,strong) IBInspectable UIColor *highlightedBackgroundColor UI_APPEARANCE_SELECTOR;

/// 点击了“复制”后的回调
@property(nonatomic, copy) void (^didCopyBlock)(Label *label, NSString *stringCopied);

@end
