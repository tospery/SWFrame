//
//  UIImage+Ex.h
//  SWFrame
//
//  Created by liaoya on 2021/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GradientDirection) {
    GradientDirectionTopToBottom = 0,   // 从上到下
    GradientDirectionLeftToRight = 1,   // 从左到右
};

@interface UIImage (Ex)
/**
 *  保持当前图片的形状不变，使用指定的颜色去重新渲染它，生成一张新图片并返回
 *
 *  @param tintColor 要用于渲染的新颜色
 *
 *  @return 与当前图片形状一致但颜色与参数tintColor相同的新图片
 */
- (nullable UIImage *)qmui_imageWithTintColor:(nullable UIColor *)tintColor;

/**
 *  创建一个纯色的UIImage
 *
 *  @param  color           图片的颜色
 *  @param  size            图片的大小
 *  @param  cornerRadius    图片的圆角
 *
 * @return 纯色的UIImage
 */
+ (nullable UIImage *)qmui_imageWithColor:(nullable UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)getGradientImageFromColors:(NSArray *)colors gradientDirection:(GradientDirection)gradientDirection imgSize:(CGSize)imgSize;

@end

NS_ASSUME_NONNULL_END
