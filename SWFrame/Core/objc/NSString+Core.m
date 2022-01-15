//
//  NSString+Core.m
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

#import "NSString+Core.h"

@implementation NSString (Core)

- (NSString *)swf_capitalizedString {
    if (self.length) {
        NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:0];
        if (range.length > 1) {
            return self;// 说明这个字符没法大写
        }
        return [NSString stringWithFormat:@"%@%@", [self substringToIndex:1].uppercaseString, [self substringFromIndex:1]].copy;
    }
    return nil;
}

@end
