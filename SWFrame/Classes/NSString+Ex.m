//
//  NSString+Ex.m
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/26.
//

#import "NSString+Ex.h"

@implementation NSString (Ex)
- (NSString *)swf_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)swf_capitalizedString {
    if (self.length)
        return [NSString stringWithFormat:@"%@%@", [self substringToIndex:1].uppercaseString, [self substringFromIndex:1]].copy;
    return nil;
}

- (NSString *)swf_stringMatchedByPattern:(NSString *)pattern {
    NSRange range = [self rangeOfString:pattern options:NSRegularExpressionSearch|NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        return [self substringWithRange:range];
    }
    return nil;
}

@end
