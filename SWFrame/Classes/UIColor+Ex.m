//
//  UIColor+Ex.m
//  SWFrame
//
//  Created by 杨建祥 on 2021/10/16.
//

#import "UIColor+Ex.h"

@implementation UIColor (Ex)
- (CGFloat)qmui_alpha {
    CGFloat a;
    if ([self getRed:0 green:0 blue:0 alpha:&a]) {
        return a;
    }
    return 0;
}

@end
