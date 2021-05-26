//
//  CALayer+Ex.h
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/26.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Ex)
/**
 * 移除 CALayer（包括 CAShapeLayer 和 CAGradientLayer）所有支持动画的属性的默认动画，方便需要一个不带动画的 layer 时使用。
 */
- (void)sf_removeDefaultAnimations;

@end

NS_ASSUME_NONNULL_END
