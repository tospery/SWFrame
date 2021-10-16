//
//  NSObject+Ex.h
//  SWFrame
//
//  Created by 杨建祥 on 2021/10/16.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Ex)
/**
 *  调用一个无参数、返回值类型为非对象的 selector。如果返回值类型为对象，请直接使用系统的 performSelector: 方法。
 *  @param selector 要被调用的方法名
 *  @param returnValue selector 的返回值的指针地址，请先定义一个变量再将其指针地址传进来，例如 &result
 *
 *  @code
 *  CGFloat alpha;
 *  [view qmui_performSelector:@selector(alpha) withPrimitiveReturnValue:&alpha];
 *  @endcode
 */
- (void)qmui_performSelector:(SEL)selector withPrimitiveReturnValue:(nullable void *)returnValue;

/**
 *  调用一个返回值类型为非对象且带参数的 selector，参数类型支持对象和非对象，也没有数量限制。
 *
 *  @param selector 要被调用的方法名
 *  @param returnValue selector 的返回值的指针地址
 *  @param firstArgument 参数列表，请传参数的指针地址，支持多个参数
 *
 *  @code
 *  CGPoint point = xxx;
 *  UIEvent *event = xxx;
 *  BOOL isInside;
 *  [view qmui_performSelector:@selector(pointInside:withEvent:) withPrimitiveReturnValue:&isInside arguments:&point, &event, nil];
 *  @endcode
 */
- (void)qmui_performSelector:(SEL)selector withPrimitiveReturnValue:(nullable void *)returnValue arguments:(nullable void *)firstArgument, ...;


@end

NS_ASSUME_NONNULL_END
