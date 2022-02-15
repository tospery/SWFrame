//
//  SwiftyLoad.h
//  SWFrame
//
//  Created by liaoya on 2022/1/16.
//

#import <Foundation/Foundation.h>
#import <QMUIKit/QMUIKit.h>

#define SWIFTY_LOAD_INITIALIZE(className) \
@interface className(swizzle_swifty_hook)  \
@end    \
@implementation className(swizzle_swifty_hook) \
+ (void)load {  \
BeginIgnoreClangWarning(-Wundeclared-selector)  \
    SEL sel = @selector(swiftyLoad);    \
EndIgnoreClangWarning   \
    if ([self respondsToSelector:sel]) {    \
        ((void (*)(id, SEL))[self methodForSelector:sel])(self, sel);   \
    }   \
}   \
@end
