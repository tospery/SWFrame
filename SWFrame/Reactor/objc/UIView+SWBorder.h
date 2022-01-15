//
//  UIView+SWBorder.h
//  SWFrame
//
//  Created by liaoya on 2022/1/13.
//

#import <UIKit/UIKit.h>

// YJX_TODO 转换为swift版本

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, SWFViewBorderPosition) {
    SWFViewBorderPositionNone      = 0,
    SWFViewBorderPositionTop       = 1 << 0,
    SWFViewBorderPositionLeft      = 1 << 1,
    SWFViewBorderPositionBottom    = 1 << 2,
    SWFViewBorderPositionRight     = 1 << 3
};

typedef NS_ENUM(NSUInteger, SWFViewBorderLocation) {
    SWFViewBorderLocationInside,
    SWFViewBorderLocationCenter,
    SWFViewBorderLocationOutside
};

/**
*  UIView (SWFBorder) 为 UIView 方便地显示某几个方向上的边框。
*
*  系统的默认实现里，要为 UIView 加边框一般是通过 view.layer 来实现，view.layer 会给四条边都加上边框，如果你只想为其中某几条加上边框就很麻烦，于是 UIView (SWFBorder) 提供了 swf_borderPosition 来解决这个问题。
*  @warning 注意如果你需要为 UIView 四条边都加上边框，请使用系统默认的 view.layer 来实现，而不要用 UIView (SWFBorder)，会浪费资源，这也是为什么 SWFViewBorderPosition 不提供一个 SWFViewBorderPositionAll 枚举值的原因。
*/
@interface UIView (SWFBorder)

/// 设置边框的位置，默认为 SWFViewBorderLocationInside，与 view.layer.border 一致。
@property(nonatomic, assign) SWFViewBorderLocation swf_borderLocation;

/// 设置边框类型，支持组合，例如：`borderPosition = SWFViewBorderPositionTop|SWFViewBorderPositionBottom`。默认为 SWFViewBorderPositionNone。
@property(nonatomic, assign) SWFViewBorderPosition swf_borderPosition;

/// 边框的大小，默认为PixelOne。请注意修改 swf_borderPosition 的值以将边框显示出来。
@property(nonatomic, assign) IBInspectable CGFloat swf_borderWidth;

/**
 边框的偏移，默认为 UIEdgeInsetsZero，当某个方向的值为正值，则边框会往内缩，负值则边框会往外拓。但对于不同的边框线，borderInsets 的 top/left/bottom/right 会对应不同的方向，具体如下：
 1. 对于 SWFViewBorderPositionTop 而言，边框从左往右绘制。所以 left 正值则边框的左端点往右缩（右端点不变），right 正值则边框的右端点往左缩（左端点不变）。top 正值则边框往下偏移，bottom 正值则边框往上偏移。
 2. 对于 SWFViewBorderPositionLeft 而言，边框从下往上绘制。所以 left 正值则边框的底端点往上缩（顶端点不变），right 正值则边框的顶端点往底缩（底端点不变）。top 正值则边框往右偏移，bottom 正值则边框往左偏移。
 3. 对于 SWFViewBorderPositionBottom 而言，边框从右下往左下绘制。所以 left 正值则边框的右下端点往左缩（左端点不变），right 正值则边框的左下端点往右缩（右端点不变）。top 正值则边框往上偏移，bottom 正值则边框往下偏移。
 4. 对于 SWFViewBorderPositionRight 而言，边框从上往下绘制。所以 left 正值则边框的顶端点往下缩（底端点不变），right 正值则边框的底端点往上缩（顶端点不变）。top 正值则边框往左偏移，bottom 正值则边框往右偏移。
 */
@property(nonatomic, assign) IBInspectable UIEdgeInsets swf_borderInsets;

/// 边框的颜色，默认为UIColorSeparator。请注意修改 swf_borderPosition 的值以将边框显示出来。
@property(nullable, nonatomic, strong) IBInspectable UIColor *swf_borderColor;

/// 虚线 : dashPhase默认是0，且当dashPattern设置了才有效
/// swf_dashPhase 表示虚线起始的偏移，swf_dashPattern 可以传一个数组，表示“lineWidth，lineSpacing，lineWidth，lineSpacing...”的顺序，至少传 2 个。
@property(nonatomic, assign) CGFloat swf_dashPhase;
@property(nullable, nonatomic, copy) NSArray<NSNumber *> *swf_dashPattern;

/// border的layer
@property(nullable, nonatomic, strong, readonly) CAShapeLayer *swf_borderLayer;

@end

NS_ASSUME_NONNULL_END

