//
//  UIColor+Ex.h
//  SWFrame
//
//  Created by 杨建祥 on 2021/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Ex)
/**
 *  获取当前 UIColor 对象里的透明色值
 *
 *  @return 透明通道的色值，值范围为0.0-1.0
 */
@property(nonatomic, assign, readonly) CGFloat qmui_alpha;

@end

NS_ASSUME_NONNULL_END
