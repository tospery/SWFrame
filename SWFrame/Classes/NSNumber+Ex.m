//
//  NSNumber+Ex.m
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/26.
//

#import "NSNumber+Ex.h"

@implementation NSNumber (Ex)

- (CGFloat)sf_CGFloatValue {
#if CGFLOAT_IS_DOUBLE
    return self.doubleValue;
#else
    return self.floatValue;
#endif
}

@end
