//
//  WeakObjectContainer.h
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 一个常见的场景：当通过 objc_setAssociatedObject 以弱引用的方式（OBJC_ASSOCIATION_ASSIGN）绑定对象A时，假如对象A稍后被释放了，则通过 objc_getAssociatedObject 再次试图访问对象A时会导致野指针。
 这时你可以将对象A包装为一个 WeakObjectContainer，并改为通过强引用方式（OBJC_ASSOCIATION_RETAIN_NONATOMIC/OBJC_ASSOCIATION_RETAIN）绑定这个 WeakObjectContainer，进而安全地获取原始对象A。
 */
@interface WeakObjectContainer : NSProxy

/// 将一个 object 包装到一个 WeakObjectContainer 里
- (instancetype)initWithObject:(id)object;
- (instancetype)init;
+ (instancetype)containerWithObject:(id)object;

/// 获取原始对象 object，如果 object 已被释放则该属性返回 nil
@property (nullable, nonatomic, weak) id object;

@end

NS_ASSUME_NONNULL_END

