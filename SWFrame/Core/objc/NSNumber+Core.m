//
//  NSNumber+Core.m
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

#import "NSNumber+Core.h"

@implementation NSNumber (Core)

- (CGFloat)swf_CGFloatValue {
#if CGFLOAT_IS_DOUBLE
    return self.doubleValue;
#else
    return self.floatValue;
#endif
}

@end
