//
//  CALayer+Ex.h
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/26.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define SWFCGColorOriginalColorBindKey      @"SWFCGColorOriginalColorBindKey"

typedef NS_OPTIONS (NSUInteger, SWFCornerMask) {
    SWFLayerMinXMinYCorner = 1U << 0,
    SWFLayerMaxXMinYCorner = 1U << 1,
    SWFLayerMinXMaxYCorner = 1U << 2,
    SWFLayerMaxXMaxYCorner = 1U << 3,
    SWFLayerAllCorner = SWFLayerMinXMinYCorner|SWFLayerMaxXMinYCorner|SWFLayerMinXMaxYCorner|SWFLayerMaxXMaxYCorner,
};

@interface CALayer (Ex)

/// 是否为某个 UIView 自带的 layer
@property(nonatomic, assign, readonly) BOOL swf_isRootLayerOfView;

/// 暂停/恢复当前 layer 上的所有动画
@property(nonatomic, assign) BOOL swf_pause;

/**
 *  设置四个角是否支持圆角的，iOS11 及以上会调用系统的接口，否则 SWF 额外实现
 *  @warning 如果对应的 layer 有圆角，则请使用 SWFBorder，否则系统的 border 会被 clip 掉
 *  @warning 使用 swf 方法，则超出 layer 范围内的内容都会被 clip 掉，系统的则不会
 *  @warning 如果使用这个接口设置圆角，那么需要获取圆角的值需要用 swf_originCornerRadius，否则 iOS 11 以下获取到的都是 0
 */
@property(nonatomic, assign) SWFCornerMask swf_maskedCorners;

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

/**
 * 对 CALayer 执行一些操作，不以动画的形式展示过程（默认情况下修改 CALayer 的属性都会以动画形式展示出来）。
 * @param actionsWithoutAnimation 要执行的操作，可以在里面修改 layer 的属性，例如 frame、backgroundColor 等。
 * @note 如果该 layer 的任何属性修改都不需要动画，也可使用 swf_removeDefaultAnimations。
 */
+ (void)swf_performWithoutAnimation:(void (NS_NOESCAPE ^)(void))actionsWithoutAnimation;

/**
 * 生成虚线的方法，注意返回的是 CAShapeLayer
 * @param lineLength   每一段的线宽
 * @param lineSpacing  线之间的间隔
 * @param lineWidth    线的宽度
 * @param lineColor    线的颜色
 * @param isHorizontal 是否横向，因为画虚线的缘故，需要指定横向或纵向，横向是 YES，纵向是 NO。
 * 注意：暂不支持 dashPhase 和 dashPattens 数组设置，因为这些都定制性太强，如果用到则自己调用系统方法即可。
 */
+ (CAShapeLayer *)swf_separatorDashLayerWithLineLength:(NSInteger)lineLength
                                            lineSpacing:(NSInteger)lineSpacing
                                              lineWidth:(CGFloat)lineWidth
                                              lineColor:(CGColorRef)lineColor
                                           isHorizontal:(BOOL)isHorizontal;

/**
 
 * 产生一个通用分隔虚线的 layer，高度为 PixelOne，线宽为 2，线距为 2，默认会移除动画，并且背景色用 UIColorMake(222, 224, 226)，注意返回的是 CAShapeLayer。
 
 * 其中，InHorizon 是横向；InVertical 是纵向。
 
 */
+ (CAShapeLayer *)swf_separatorDashLayerInHorizontal;

+ (CAShapeLayer *)swf_separatorDashLayerInVertical;

/**
 * 产生一个适用于做通用分隔线的 layer，高度为 PixelOne，默认会移除动画，并且背景色用 UIColorMake(222, 224, 226)
 */
+ (CALayer *)swf_separatorLayer;

/**
 * 产生一个适用于做列表分隔线的 layer，高度为 PixelOne，默认会移除动画，并且背景色用 UIColorMake(222, 224, 226)
 */
+ (CALayer *)swf_separatorLayerForTableView;

@end

@interface CALayer (Ex_DynamicColor)

/// 如果 layer 的 backgroundColor、borderColor、shadowColor 是使用 dynamic color（UIDynamicProviderColor、SWFThemeColor 等）生成的，则调用这个方法可以重新设置一遍这些属性，从而更新颜色
/// iOS 13 系统设置里的界面样式变化（Dark Mode），以及 SWFThemeManager 触发的主题变化，都会自动调用 layer 的这个方法，业务无需关心。
- (void)swf_setNeedsUpdateDynamicStyle NS_REQUIRES_SUPER;
@end
