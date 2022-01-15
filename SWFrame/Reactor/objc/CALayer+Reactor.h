//
//  CALayer+SWFrame.h
//  SWFrame
//
//  Created by liaoya on 2022/1/13.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (SWFrame)

/// iOS11 以下 layer 自身的 cornerRadius 一直都是 0，圆角的是通过 mask 做的，swf_originCornerRadius 保存了当前的圆角
@property(nonatomic, assign, readonly) CGFloat swf_originCornerRadius;

/**
 *  把某个 sublayer 移动到当前所有 sublayers 的最后面
 *  @param sublayer 要被移动的 layer
 *  @warning 要被移动的 sublayer 必须已经添加到当前 layer 上
 */
- (void)swf_sendSublayerToBack:(CALayer *)sublayer;

/**
 *  把某个 sublayer 移动到当前所有 sublayers 的最前面
 *  @param sublayer 要被移动的layer
 *  @warning 要被移动的 sublayer 必须已经添加到当前 layer 上
 */
- (void)swf_bringSublayerToFront:(CALayer *)sublayer;

/**
 * 移除 CALayer（包括 CAShapeLayer 和 CAGradientLayer）所有支持动画的属性的默认动画，方便需要一个不带动画的 layer 时使用。
 */
- (void)swf_removeDefaultAnimations;

@end

