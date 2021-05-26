//
//  NSMethodSignature+Ex.h
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMethodSignature (Ex)

/**
 返回一个避免 crash 的方法签名，用于重写 methodSignatureForSelector: 时作为垫底的 return 方案
 */
@property(nullable, class, nonatomic, readonly) NSMethodSignature *sf_avoidExceptionSignature;

/**
 以 NSString 格式返回当前 NSMethodSignature 的 typeEncoding，例如 v@:
 */
@property(nullable, nonatomic, copy, readonly) NSString *sf_typeString;

/**
 以 const char 格式返回当前 NSMethodSignature 的 typeEncoding，例如 v@:
 */
@property(nullable, nonatomic, readonly) const char *sf_typeEncoding;
@end

NS_ASSUME_NONNULL_END

