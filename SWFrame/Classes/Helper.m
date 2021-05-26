//
//  Helper.m
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/26.
//

#import "Helper.h"
#import "Defines.h"
// YJX_TODO #import "UIViewController+Ex.h"
// YJX_TODO #import "UIInterface+Ex.h"
#import "NSNumber+Ex.h"
#import "NSObject+Ex.h"
#import "NSString+Ex.h"
#import <AVFoundation/AVFoundation.h>
#import <math.h>
#import <sys/utsname.h>

const CGPoint SWBadgeInvalidateOffset = {-1000, -1000};
NSString *const kSWResourcesBundleName = @"SWResources";

@implementation Helper (Bundle)

+ (UIImage *)imageWithName:(NSString *)name {
    static NSBundle *resourceBundle = nil;
    if (!resourceBundle) {
        NSBundle *mainBundle = [NSBundle bundleForClass:self];
        NSString *resourcePath = [mainBundle pathForResource:kSWResourcesBundleName ofType:@"bundle"];
        resourceBundle = [NSBundle bundleWithPath:resourcePath] ?: mainBundle;
    }
    UIImage *image = [UIImage imageNamed:name inBundle:resourceBundle compatibleWithTraitCollection:nil];
    return image;
}

@end


@implementation Helper (DynamicType)

+ (NSNumber *)preferredContentSizeLevel {
    NSNumber *index = nil;
    if ([UIApplication instancesRespondToSelector:@selector(preferredContentSizeCategory)]) {
        NSString *contentSizeCategory = UIApplication.sharedApplication.preferredContentSizeCategory;
        if ([contentSizeCategory isEqualToString:UIContentSizeCategoryExtraSmall]) {
            index = [NSNumber numberWithInt:0];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategorySmall]) {
            index = [NSNumber numberWithInt:1];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryMedium]) {
            index = [NSNumber numberWithInt:2];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryLarge]) {
            index = [NSNumber numberWithInt:3];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryExtraLarge]) {
            index = [NSNumber numberWithInt:4];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryExtraExtraLarge]) {
            index = [NSNumber numberWithInt:5];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryExtraExtraExtraLarge]) {
            index = [NSNumber numberWithInt:6];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryAccessibilityMedium]) {
            index = [NSNumber numberWithInt:6];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryAccessibilityLarge]) {
            index = [NSNumber numberWithInt:6];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryAccessibilityExtraLarge]) {
            index = [NSNumber numberWithInt:6];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryAccessibilityExtraExtraLarge]) {
            index = [NSNumber numberWithInt:6];
        } else if ([contentSizeCategory isEqualToString:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge]) {
            index = [NSNumber numberWithInt:6];
        } else{
            index = [NSNumber numberWithInt:6];
        }
    } else {
        index = [NSNumber numberWithInt:3];
    }
    
    return index;
}

+ (CGFloat)heightForDynamicTypeCell:(NSArray *)heights {
    NSNumber *index = [Helper preferredContentSizeLevel];
    return [((NSNumber *)[heights objectAtIndex:[index intValue]]) sf_CGFloatValue];
}
@end

@implementation Helper (Keyboard)

SWSynthesizeBOOLProperty(keyboardVisible, setKeyboardVisible)
SWSynthesizeCGFloatProperty(lastKeyboardHeight, setLastKeyboardHeight)

- (void)handleKeyboardWillShow:(NSNotification *)notification {
    self.keyboardVisible = YES;
    self.lastKeyboardHeight = [Helper keyboardHeightWithNotification:notification];
}

- (void)handleKeyboardWillHide:(NSNotification *)notification {
    self.keyboardVisible = NO;
}

+ (BOOL)isKeyboardVisible {
    BOOL visible = [Helper sharedInstance].keyboardVisible;
    return visible;
}

+ (CGFloat)lastKeyboardHeightInApplicationWindowWhenVisible {
    return [Helper sharedInstance].lastKeyboardHeight;
}

+ (CGRect)keyboardRectWithNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 注意iOS8以下的系统在横屏时得到的rect，宽度和高度相反了，所以不建议直接通过这个方法获取高度，而是使用<code>keyboardHeightWithNotification:inView:</code>，因为在后者的实现里会将键盘的rect转换坐标系，转换过程就会处理横竖屏旋转问题。
    return keyboardRect;
}

+ (CGFloat)keyboardHeightWithNotification:(NSNotification *)notification {
    return [Helper keyboardHeightWithNotification:notification inView:nil];
}

+ (CGFloat)keyboardHeightWithNotification:(nullable NSNotification *)notification inView:(nullable UIView *)view {
    CGRect keyboardRect = [self keyboardRectWithNotification:notification];
    if (@available(iOS 13.0, *)) {
        // iOS 13 分屏键盘 x 不是 0，不知道是系统 BUG 还是故意这样，先这样保护，再观察一下后面的 beta 版本
        if (IS_SPLIT_SCREEN_IPAD && keyboardRect.origin.x > 0) {
            keyboardRect.origin.x = 0;
        }
    }
    if (!view) { return CGRectGetHeight(keyboardRect); }
    CGRect keyboardRectInView = [view convertRect:keyboardRect fromView:view.window];
    CGRect keyboardVisibleRectInView = CGRectIntersection(view.bounds, keyboardRectInView);
    CGFloat resultHeight = CGRectIsValidated(keyboardVisibleRectInView) ? CGRectGetHeight(keyboardVisibleRectInView) : 0;
    return resultHeight;
}

+ (NSTimeInterval)keyboardAnimationDurationWithNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    return animationDuration;
}

+ (UIViewAnimationCurve)keyboardAnimationCurveWithNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    UIViewAnimationCurve curve = (UIViewAnimationCurve)[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    return curve;
}

+ (UIViewAnimationOptions)keyboardAnimationOptionsWithNotification:(NSNotification *)notification {
    UIViewAnimationOptions options = [Helper keyboardAnimationCurveWithNotification:notification]<<16;
    return options;
}

@end


@implementation Helper (AudioSession)

+ (void)redirectAudioRouteWithSpeaker:(BOOL)speaker temporary:(BOOL)temporary {
    if (![[AVAudioSession sharedInstance].category isEqualToString:AVAudioSessionCategoryPlayAndRecord]) {
        return;
    }
    if (temporary) {
        [[AVAudioSession sharedInstance] overrideOutputAudioPort:speaker ? AVAudioSessionPortOverrideSpeaker : AVAudioSessionPortOverrideNone error:nil];
    } else {
        [[AVAudioSession sharedInstance] setCategory:[AVAudioSession sharedInstance].category withOptions:speaker ? AVAudioSessionCategoryOptionDefaultToSpeaker : 0 error:nil];
    }
}

+ (void)setAudioSessionCategory:(nullable NSString *)category {
    
    // 如果不属于系统category，返回
    if (category != AVAudioSessionCategoryAmbient &&
        category != AVAudioSessionCategorySoloAmbient &&
        category != AVAudioSessionCategoryPlayback &&
        category != AVAudioSessionCategoryRecord &&
        category != AVAudioSessionCategoryPlayAndRecord)
    {
        return;
    }
    
    [[AVAudioSession sharedInstance] setCategory:category error:nil];
}

@end


@implementation Helper (UIGraphic)

static CGFloat pixelOne = -1.0f;
+ (CGFloat)pixelOne {
    if (pixelOne < 0) {
        pixelOne = 1 / [[UIScreen mainScreen] scale];
    }
    return pixelOne;
}

+ (void)inspectContextSize:(CGSize)size {
    if (!CGSizeIsValidated(size)) {
        NSAssert(NO, @"SWFrame CGPostError, %@:%d %s, 非法的size：%@\n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, NSStringFromCGSize(size), [NSThread callStackSymbols]);
    }
}

+ (void)inspectContextIfInvalidatedInDebugMode:(CGContextRef)context {
    if (!context) {
        // crash了就找zhoon或者molice
        NSAssert(NO, @"SWFrame CGPostError, %@:%d %s, 非法的context：%@\n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, context, [NSThread callStackSymbols]);
    }
}

+ (BOOL)inspectContextIfInvalidatedInReleaseMode:(CGContextRef)context {
    if (context) {
        return YES;
    }
    return NO;
}

@end

@implementation Helper (Device)

+ (NSString *)deviceModel {
    if (IS_SIMULATOR) {
        // Simulator doesn't return the identifier for the actual physical model, but returns it as an environment variable
        // 模拟器不返回物理机器信息，但会通过环境变量的方式返回
        return [NSString stringWithFormat:@"%s", getenv("SIMULATOR_MODEL_IDENTIFIER")];
    }
    
    // See https://www.theiphonewiki.com/wiki/Models for identifiers
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)deviceName {
    static dispatch_once_t onceToken;
    static NSString *name;
    dispatch_once(&onceToken, ^{
        NSString *model = [self deviceModel];
        if (!model) {
            name = @"Unknown Device";
            return;
        }
        
        NSDictionary *dict = @{
            // See https://www.theiphonewiki.com/wiki/Models
            @"iPhone1,1" : @"iPhone 1G",
            @"iPhone1,2" : @"iPhone 3G",
            @"iPhone2,1" : @"iPhone 3GS",
            @"iPhone3,1" : @"iPhone 4 (GSM)",
            @"iPhone3,2" : @"iPhone 4",
            @"iPhone3,3" : @"iPhone 4 (CDMA)",
            @"iPhone4,1" : @"iPhone 4S",
            @"iPhone5,1" : @"iPhone 5",
            @"iPhone5,2" : @"iPhone 5",
            @"iPhone5,3" : @"iPhone 5c",
            @"iPhone5,4" : @"iPhone 5c",
            @"iPhone6,1" : @"iPhone 5s",
            @"iPhone6,2" : @"iPhone 5s",
            @"iPhone7,1" : @"iPhone 6 Plus",
            @"iPhone7,2" : @"iPhone 6",
            @"iPhone8,1" : @"iPhone 6s",
            @"iPhone8,2" : @"iPhone 6s Plus",
            @"iPhone8,4" : @"iPhone SE",
            @"iPhone9,1" : @"iPhone 7",
            @"iPhone9,2" : @"iPhone 7 Plus",
            @"iPhone9,3" : @"iPhone 7",
            @"iPhone9,4" : @"iPhone 7 Plus",
            @"iPhone10,1" : @"iPhone 8",
            @"iPhone10,2" : @"iPhone 8 Plus",
            @"iPhone10,3" : @"iPhone X",
            @"iPhone10,4" : @"iPhone 8",
            @"iPhone10,5" : @"iPhone 8 Plus",
            @"iPhone10,6" : @"iPhone X",
            @"iPhone11,2" : @"iPhone XS",
            @"iPhone11,4" : @"iPhone XS Max",
            @"iPhone11,6" : @"iPhone XS Max CN",
            @"iPhone11,8" : @"iPhone XR",
            @"iPhone12,1" : @"iPhone 11",
            @"iPhone12,3" : @"iPhone 11 Pro",
            @"iPhone12,5" : @"iPhone 11 Pro Max",
            @"iPhone12,8" : @"iPhone SE (2nd generation)",
            @"iPhone13,1" : @"iPhone 12 mini",
            @"iPhone13,2" : @"iPhone 12",
            @"iPhone13,3" : @"iPhone 12 Pro",
            @"iPhone13,4" : @"iPhone 12 Pro Max",
            
            @"iPad1,1" : @"iPad 1",
            @"iPad2,1" : @"iPad 2 (WiFi)",
            @"iPad2,2" : @"iPad 2 (GSM)",
            @"iPad2,3" : @"iPad 2 (CDMA)",
            @"iPad2,4" : @"iPad 2",
            @"iPad2,5" : @"iPad mini 1",
            @"iPad2,6" : @"iPad mini 1",
            @"iPad2,7" : @"iPad mini 1",
            @"iPad3,1" : @"iPad 3 (WiFi)",
            @"iPad3,2" : @"iPad 3 (4G)",
            @"iPad3,3" : @"iPad 3 (4G)",
            @"iPad3,4" : @"iPad 4",
            @"iPad3,5" : @"iPad 4",
            @"iPad3,6" : @"iPad 4",
            @"iPad4,1" : @"iPad Air",
            @"iPad4,2" : @"iPad Air",
            @"iPad4,3" : @"iPad Air",
            @"iPad4,4" : @"iPad mini 2",
            @"iPad4,5" : @"iPad mini 2",
            @"iPad4,6" : @"iPad mini 2",
            @"iPad4,7" : @"iPad mini 3",
            @"iPad4,8" : @"iPad mini 3",
            @"iPad4,9" : @"iPad mini 3",
            @"iPad5,1" : @"iPad mini 4",
            @"iPad5,2" : @"iPad mini 4",
            @"iPad5,3" : @"iPad Air 2",
            @"iPad5,4" : @"iPad Air 2",
            @"iPad6,3" : @"iPad Pro (9.7 inch)",
            @"iPad6,4" : @"iPad Pro (9.7 inch)",
            @"iPad6,7" : @"iPad Pro (12.9 inch)",
            @"iPad6,8" : @"iPad Pro (12.9 inch)",
            @"iPad6,11": @"iPad 5 (WiFi)",
            @"iPad6,12": @"iPad 5 (Cellular)",
            @"iPad7,1" : @"iPad Pro (12.9 inch, 2nd generation)",
            @"iPad7,2" : @"iPad Pro (12.9 inch, 2nd generation)",
            @"iPad7,3" : @"iPad Pro (10.5 inch)",
            @"iPad7,4" : @"iPad Pro (10.5 inch)",
            @"iPad7,5" : @"iPad 6 (WiFi)",
            @"iPad7,6" : @"iPad 6 (Cellular)",
            @"iPad7,11": @"iPad 7 (WiFi)",
            @"iPad7,12": @"iPad 7 (Cellular)",
            @"iPad8,1" : @"iPad Pro (11 inch)",
            @"iPad8,2" : @"iPad Pro (11 inch)",
            @"iPad8,3" : @"iPad Pro (11 inch)",
            @"iPad8,4" : @"iPad Pro (11 inch)",
            @"iPad8,5" : @"iPad Pro (12.9 inch, 3rd generation)",
            @"iPad8,6" : @"iPad Pro (12.9 inch, 3rd generation)",
            @"iPad8,7" : @"iPad Pro (12.9 inch, 3rd generation)",
            @"iPad8,8" : @"iPad Pro (12.9 inch, 3rd generation)",
            @"iPad8,9" : @"iPad Pro (11 inch, 2nd generation)",
            @"iPad8,10" : @"iPad Pro (11 inch, 2nd generation)",
            @"iPad8,11" : @"iPad Pro (12.9 inch, 4th generation)",
            @"iPad8,12" : @"iPad Pro (12.9 inch, 4th generation)",
            @"iPad11,1" : @"iPad mini (5th generation)",
            @"iPad11,2" : @"iPad mini (5th generation)",
            @"iPad11,3" : @"iPad Air (3rd generation)",
            @"iPad11,4" : @"iPad Air (3rd generation)",
            @"iPad11,6" : @"iPad (WiFi)",
            @"iPad11,7" : @"iPad (Cellular)",
            @"iPad13,1" : @"iPad Air (4th generation)",
            @"iPad13,2" : @"iPad Air (4th generation)",
            
            @"iPod1,1" : @"iPod touch 1",
            @"iPod2,1" : @"iPod touch 2",
            @"iPod3,1" : @"iPod touch 3",
            @"iPod4,1" : @"iPod touch 4",
            @"iPod5,1" : @"iPod touch 5",
            @"iPod7,1" : @"iPod touch 6",
            @"iPod9,1" : @"iPod touch 7",
            
            @"i386" : @"Simulator x86",
            @"x86_64" : @"Simulator x64",
            
            @"Watch1,1" : @"Apple Watch 38mm",
            @"Watch1,2" : @"Apple Watch 42mm",
            @"Watch2,3" : @"Apple Watch Series 2 38mm",
            @"Watch2,4" : @"Apple Watch Series 2 42mm",
            @"Watch2,6" : @"Apple Watch Series 1 38mm",
            @"Watch2,7" : @"Apple Watch Series 1 42mm",
            @"Watch3,1" : @"Apple Watch Series 3 38mm",
            @"Watch3,2" : @"Apple Watch Series 3 42mm",
            @"Watch3,3" : @"Apple Watch Series 3 38mm (LTE)",
            @"Watch3,4" : @"Apple Watch Series 3 42mm (LTE)",
            @"Watch4,1" : @"Apple Watch Series 4 40mm",
            @"Watch4,2" : @"Apple Watch Series 4 44mm",
            @"Watch4,3" : @"Apple Watch Series 4 40mm (LTE)",
            @"Watch4,4" : @"Apple Watch Series 4 44mm (LTE)",
            @"Watch5,1" : @"Apple Watch Series 5 40mm",
            @"Watch5,2" : @"Apple Watch Series 5 44mm",
            @"Watch5,3" : @"Apple Watch Series 5 40mm (LTE)",
            @"Watch5,4" : @"Apple Watch Series 5 44mm (LTE)",
            @"Watch5,9" : @"Apple Watch SE 40mm",
            @"Watch5,10" : @"Apple Watch SE 44mm",
            @"Watch5,11" : @"Apple Watch SE 40mm",
            @"Watch5,12" : @"Apple Watch SE 44mm",
            @"Watch6,1"  : @"Apple Watch Series 6 40mm",
            @"Watch6,2"  : @"Apple Watch Series 6 44mm",
            @"Watch6,3"  : @"Apple Watch Series 6 40mm",
            @"Watch6,4"  : @"Apple Watch Series 6 44mm",
            
            @"AudioAccessory1,1" : @"HomePod",
            @"AudioAccessory1,2" : @"HomePod",
            @"AudioAccessory5,1" : @"HomePod mini",
            
            @"AirPods1,1" : @"AirPods (1st generation)",
            @"AirPods2,1" : @"AirPods (2nd generation)",
            @"iProd8,1"   : @"AirPods Pro",
            
            @"AppleTV2,1" : @"Apple TV 2",
            @"AppleTV3,1" : @"Apple TV 3",
            @"AppleTV3,2" : @"Apple TV 3",
            @"AppleTV5,3" : @"Apple TV 4",
            @"AppleTV6,2" : @"Apple TV 4K",
        };
        name = dict[model];
        if (!name) name = model;
        if (IS_SIMULATOR) name = [name stringByAppendingString:@" Simulator"];
    });
    return name;
}

static NSInteger isIPad = -1;
+ (BOOL)isIPad {
    if (isIPad < 0) {
        // [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] 无法判断模拟器 iPad，所以改为以下方式
        isIPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 1 : 0;
    }
    return isIPad > 0;
}

static NSInteger isIPod = -1;
+ (BOOL)isIPod {
    if (isIPod < 0) {
        NSString *string = [[UIDevice currentDevice] model];
        isIPod = [string rangeOfString:@"iPod touch"].location != NSNotFound ? 1 : 0;
    }
    return isIPod > 0;
}

static NSInteger isIPhone = -1;
+ (BOOL)isIPhone {
    if (isIPhone < 0) {
        NSString *string = [[UIDevice currentDevice] model];
        isIPhone = [string rangeOfString:@"iPhone"].location != NSNotFound ? 1 : 0;
    }
    return isIPhone > 0;
}

static NSInteger isSimulator = -1;
+ (BOOL)isSimulator {
    if (isSimulator < 0) {
#if TARGET_OS_SIMULATOR
        isSimulator = 1;
#else
        isSimulator = 0;
#endif
    }
    return isSimulator > 0;
}


+ (BOOL)isMac {
#ifdef IOS14_SDK_ALLOWED
    if (@available(iOS 14.0, *)) {
        return [NSProcessInfo processInfo].isiOSAppOnMac || [NSProcessInfo processInfo].isMacCatalystApp;
    }
#endif
    if (@available(iOS 13.0, *)) {
        return [NSProcessInfo processInfo].isMacCatalystApp;
    }
    return NO;
}

static NSInteger isNotchedScreen = -1;
+ (BOOL)isNotchedScreen {
    if (@available(iOS 11, *)) {
        if (isNotchedScreen < 0) {
            if (@available(iOS 12.0, *)) {
                /*
                 检测方式解释/测试要点：
                 1. iOS 11 与 iOS 12 可能行为不同，所以要分别测试。
                 2. 与触发 [Helper isNotchedScreen] 方法时的进程有关，例如[NSObject performSelectorOnMainThread:withObject:waitUntilDone:NO] 就会导致较多的异常。
                 3. iOS 12 下，在非第2点里提到的情况下，iPhone、iPad 均可通过 UIScreen -_peripheryInsets 方法的返回值区分，但如果满足了第2点，则 iPad 无法使用这个方法，这种情况下要依赖第4点。
                 4. iOS 12 下，不管是否满足第2点，不管是什么设备类型，均可以通过一个满屏的 UIWindow 的 rootViewController.view.frame.origin.y 的值来区分，如果是非全面屏，这个值必定为20，如果是全面屏，则可能是24或44等不同的值。但由于创建 UIWindow、UIViewController 等均属于较大消耗，所以只在前面的步骤无法区分的情况下才会使用第4点。
                 5. 对于第4点，经测试与当前设备的方向、是否有勾选 project 里的 General - Hide status bar、当前是否处于来电模式的状态栏这些都没关系。
                 */
                SEL peripheryInsetsSelector = NSSelectorFromString([NSString stringWithFormat:@"_%@%@", @"periphery", @"Insets"]);
                UIEdgeInsets peripheryInsets = UIEdgeInsetsZero;
                [[UIScreen mainScreen] sf_performSelector:peripheryInsetsSelector withPrimitiveReturnValue:&peripheryInsets];
                if (peripheryInsets.bottom <= 0) {
                    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
                    peripheryInsets = window.safeAreaInsets;
                    if (peripheryInsets.bottom <= 0) {
                        UIViewController *viewController = [UIViewController new];
                        window.rootViewController = viewController;
                        if (CGRectGetMinY(viewController.view.frame) > 20) {
                            peripheryInsets.bottom = 1;
                        }
                    }
                }
                isNotchedScreen = peripheryInsets.bottom > 0 ? 1 : 0;
            } else {
                isNotchedScreen = [Helper is58InchScreen] ? 1 : 0;
            }
        }
    } else {
        isNotchedScreen = 0;
    }
    
    return isNotchedScreen > 0;
}

+ (BOOL)isRegularScreen {
    return [self isIPad] || (!IS_ZOOMEDMODE && ([self is67InchScreen] || [self is65InchScreen] || [self is61InchScreen] || [self is55InchScreen]));
}

static NSInteger is67InchScreen = -1;
+ (BOOL)is67InchScreen {
    if (is67InchScreen < 0) {
        is67InchScreen = (DEVICE_WIDTH == self.screenSizeFor67Inch.width && DEVICE_HEIGHT == self.screenSizeFor67Inch.height) ? 1 : 0;
    }
    return is67InchScreen > 0;
}

static NSInteger is65InchScreen = -1;
+ (BOOL)is65InchScreen {
    if (is65InchScreen < 0) {
        // Since iPhone XS Max、iPhone 11 Pro Max and iPhone XR share the same resolution, we have to distinguish them using the model identifiers
        // 由于 iPhone XS Max、iPhone 11 Pro Max 这两款机型和 iPhone XR 的屏幕宽高是一致的，我们通过机器 Identifier 加以区别
        is65InchScreen = (DEVICE_WIDTH == self.screenSizeFor65Inch.width && DEVICE_HEIGHT == self.screenSizeFor65Inch.height && ([[Helper deviceModel] isEqualToString:@"iPhone11,4"] || [[Helper deviceModel] isEqualToString:@"iPhone11,6"] || [[Helper deviceModel] isEqualToString:@"iPhone12,5"])) ? 1 : 0;
    }
    return is65InchScreen > 0;
}

static NSInteger is61InchScreenAndiPhone12 = -1;
+ (BOOL)is61InchScreenAndiPhone12 {
    if (is61InchScreenAndiPhone12 < 0) {
        is61InchScreenAndiPhone12 = (DEVICE_WIDTH == self.screenSizeFor61InchAndiPhone12.width && DEVICE_HEIGHT == self.screenSizeFor61InchAndiPhone12.height && ([[Helper deviceModel] isEqualToString:@"iPhone13,2"] || [[Helper deviceModel] isEqualToString:@"iPhone13,3"])) ? 1 : 0;
    }
    return is61InchScreenAndiPhone12 > 0;
}

static NSInteger is61InchScreen = -1;
+ (BOOL)is61InchScreen {
    if (is61InchScreen < 0) {
        is61InchScreen = (DEVICE_WIDTH == self.screenSizeFor61Inch.width && DEVICE_HEIGHT == self.screenSizeFor61Inch.height && ([[Helper deviceModel] isEqualToString:@"iPhone11,8"] || [[Helper deviceModel] isEqualToString:@"iPhone12,1"])) ? 1 : 0;
    }
    return is61InchScreen > 0;
}

static NSInteger is58InchScreen = -1;
+ (BOOL)is58InchScreen {
    if (is58InchScreen < 0) {
        // Both iPhone XS and iPhone X share the same actual screen sizes, so no need to compare identifiers
        // iPhone XS 和 iPhone X 的物理尺寸是一致的，因此无需比较机器 Identifier
        is58InchScreen = (DEVICE_WIDTH == self.screenSizeFor58Inch.width && DEVICE_HEIGHT == self.screenSizeFor58Inch.height) ? 1 : 0;
    }
    return is58InchScreen > 0;
}

static NSInteger is55InchScreen = -1;
+ (BOOL)is55InchScreen {
    if (is55InchScreen < 0) {
        is55InchScreen = (DEVICE_WIDTH == self.screenSizeFor55Inch.width && DEVICE_HEIGHT == self.screenSizeFor55Inch.height) ? 1 : 0;
    }
    return is55InchScreen > 0;
}

static NSInteger is54InchScreen = -1;
+ (BOOL)is54InchScreen {
    if (is54InchScreen < 0) {
        is54InchScreen = (DEVICE_WIDTH == self.screenSizeFor54Inch.width && DEVICE_HEIGHT == self.screenSizeFor54Inch.height) ? 1 : 0;
    }
    return is54InchScreen > 0;
}

static NSInteger is47InchScreen = -1;
+ (BOOL)is47InchScreen {
    if (is47InchScreen < 0) {
        is47InchScreen = (DEVICE_WIDTH == self.screenSizeFor47Inch.width && DEVICE_HEIGHT == self.screenSizeFor47Inch.height) ? 1 : 0;
    }
    return is47InchScreen > 0;
}

static NSInteger is40InchScreen = -1;
+ (BOOL)is40InchScreen {
    if (is40InchScreen < 0) {
        is40InchScreen = (DEVICE_WIDTH == self.screenSizeFor40Inch.width && DEVICE_HEIGHT == self.screenSizeFor40Inch.height) ? 1 : 0;
    }
    return is40InchScreen > 0;
}

static NSInteger is35InchScreen = -1;
+ (BOOL)is35InchScreen {
    if (is35InchScreen < 0) {
        is35InchScreen = (DEVICE_WIDTH == self.screenSizeFor35Inch.width && DEVICE_HEIGHT == self.screenSizeFor35Inch.height) ? 1 : 0;
    }
    return is35InchScreen > 0;
}

+ (CGSize)screenSizeFor67Inch {
    return CGSizeMake(428, 926);
}

+ (CGSize)screenSizeFor65Inch {
    return CGSizeMake(414, 896);
}

+ (CGSize)screenSizeFor61InchAndiPhone12 {
    return CGSizeMake(390, 844);
}

+ (CGSize)screenSizeFor61Inch {
    return CGSizeMake(414, 896);
}

+ (CGSize)screenSizeFor58Inch {
    return CGSizeMake(375, 812);
}

+ (CGSize)screenSizeFor55Inch {
    return CGSizeMake(414, 736);
}

+ (CGSize)screenSizeFor54Inch {
    return CGSizeMake(375, 812);
}

+ (CGSize)screenSizeFor47Inch {
    return CGSizeMake(375, 667);
}

+ (CGSize)screenSizeFor40Inch {
    return CGSizeMake(320, 568);
}

+ (CGSize)screenSizeFor35Inch {
    return CGSizeMake(320, 480);
}

static CGFloat preferredLayoutWidth = -1;
+ (CGFloat)preferredLayoutAsSimilarScreenWidthForIPad {
    if (preferredLayoutWidth < 0) {
        NSArray<NSNumber *> *widths = @[@([self screenSizeFor65Inch].width),
                                        @([self screenSizeFor58Inch].width),
                                        @([self screenSizeFor40Inch].width)];
        preferredLayoutWidth = SCREEN_WIDTH;
        UIWindow *window = UIApplication.sharedApplication.delegate.window ?: [[UIWindow alloc] init];// iOS 9 及以上的系统，新 init 出来的 window 自动被设置为当前 App 的宽度
        CGFloat windowWidth = CGRectGetWidth(window.bounds);
        for (NSInteger i = 0; i < widths.count; i++) {
            if (windowWidth <= widths[i].sf_CGFloatValue) {
                preferredLayoutWidth = widths[i].sf_CGFloatValue;
                continue;
            }
        }
    }
    return preferredLayoutWidth;
}

+ (UIEdgeInsets)safeAreaInsetsForDeviceWithNotch {
    if (![self isNotchedScreen]) {
        return UIEdgeInsetsZero;
    }
    
    if ([self isIPad]) {
        return UIEdgeInsetsMake(0, 0, 20, 0);
    }
    
    static NSDictionary<NSString *, NSDictionary<NSNumber *, NSValue *> *> *dict;
    if (!dict) {
        dict = @{
            // iPhone 12 mini
            @"iPhone13,1": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(50, 0, 34, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 50, 21, 50)],
            },
            @"iPhone13,1-Zoom": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(43, 0, 29, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 43, 21, 43)],
            },
            // iPhone 12
            @"iPhone13,2": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(47, 0, 34, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 47, 21, 47)],
            },
            @"iPhone13,2-Zoom": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(39, 0, 28, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 39, 21, 39)],
            },
            // iPhone 12 Pro
            @"iPhone13,3": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(47, 0, 34, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 47, 21, 47)],
            },
            @"iPhone13,3-Zoom": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(39, 0, 28, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 39, 21, 39)],
            },
            // iPhone 12 Pro Max
            @"iPhone13,4": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(47, 0, 34, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 47, 21, 47)],
            },
            @"iPhone13,4-Zoom": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(41, 0, 29 + 2.0 / 3.0, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 41, 21, 41)],
            },
            // iPhone 11
            @"iPhone12,1": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(48, 0, 34, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 48, 21, 48)],
            },
            @"iPhone12,1-Zoom": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(44, 0, 31, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 44, 21, 44)],
            },
            // iPhone 11 Pro Max
            @"iPhone12,5": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(44, 0, 34, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 44, 21, 44)],
            },
            @"iPhone12,5-Zoom": @{
                    @(UIInterfaceOrientationPortrait): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(40, 0, 30 + 2.0 / 3.0, 0)],
                    @(UIInterfaceOrientationLandscapeLeft): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 40, 21, 40)],
            },
        };
    }
    
    NSString *deviceKey = [Helper deviceModel];
    if (!dict[deviceKey]) {
        deviceKey = @"iPhone12,5";// 默认按 iPhone 11 Pro Max
    }
    if ([Helper isZoomedMode]) {
        deviceKey = [NSString stringWithFormat:@"%@-Zoom", deviceKey];
    }
    
    NSNumber *orientationKey = nil;
    UIInterfaceOrientation orientation = UIApplication.sharedApplication.statusBarOrientation;
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            orientationKey = @(UIInterfaceOrientationLandscapeLeft);
            break;
        default:
            orientationKey = @(UIInterfaceOrientationPortrait);
            break;
    }
    
    UIEdgeInsets insets = dict[deviceKey][orientationKey].UIEdgeInsetsValue;
    if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        insets = UIEdgeInsetsMake(insets.bottom, insets.left, insets.top, insets.right);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        insets = UIEdgeInsetsMake(insets.top, insets.right, insets.bottom, insets.left);
    }
    return insets;
}

static NSInteger isHighPerformanceDevice = -1;
+ (BOOL)isHighPerformanceDevice {
    if (isHighPerformanceDevice < 0) {
        NSString *model = [Helper deviceModel];
        NSString *identifier = [model sf_stringMatchedByPattern:@"\\d+"];
        NSInteger version = identifier.integerValue;
        if (IS_IPAD) {
            isHighPerformanceDevice = version >= 5 ? 1 : 0;// iPad Air 2
        } else {
            isHighPerformanceDevice = version >= 10 ? 1 : 0;// iPhone 8
        }
    }
    return isHighPerformanceDevice > 0;
}

+ (BOOL)isZoomedMode {
    if (!IS_IPHONE) {
        return NO;
    }
    
    CGFloat nativeScale = UIScreen.mainScreen.nativeScale;
    CGFloat scale = UIScreen.mainScreen.scale;
    
    // 对于所有的 Plus 系列 iPhone，屏幕物理像素低于软件层面的渲染像素，不管标准模式还是放大模式，nativeScale 均小于 scale，所以需要特殊处理才能准确区分放大模式
    // https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    BOOL shouldBeDownsampledDevice = CGSizeEqualToSize(UIScreen.mainScreen.nativeBounds.size, CGSizeMake(1080, 1920));
    if (shouldBeDownsampledDevice) {
        scale /= 1.15;
    }
    
    return nativeScale > scale;
}

- (void)handleAppSizeWillChange:(NSNotification *)notification {
    preferredLayoutWidth = -1;
}

+ (CGSize)applicationSize {
    /// applicationFrame 在 iPad 下返回的 size 要比 window 实际的 size 小，这个差值体现在 origin 上，所以用 origin + size 修正得到正确的大小。
    BeginIgnoreDeprecatedWarning
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    EndIgnoreDeprecatedWarning
    return CGSizeMake(applicationFrame.size.width + applicationFrame.origin.x, applicationFrame.size.height + applicationFrame.origin.y);
}

@end

@implementation Helper (UIApplication)

+ (void)dimmedApplicationWindow {
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    window.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    [window tintColorDidChange];
}

+ (void)resetDimmedApplicationWindow {
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    window.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    [window tintColorDidChange];
}

+ (UIStatusBarStyle)statusBarStyleDarkContent {
    if (@available(iOS 13.0, *))
        return UIStatusBarStyleDarkContent;
    else
        return UIStatusBarStyleDefault;
}

@end

@implementation Helper (Animation)

+ (void)executeAnimationBlock:(__attribute__((noescape)) void (^)(void))animationBlock completionBlock:(__attribute__((noescape)) void (^)(void))completionBlock {
    if (!animationBlock) return;
    [CATransaction begin];
    [CATransaction setCompletionBlock:completionBlock];
    animationBlock();
    [CATransaction commit];
}

@end

@implementation Helper (SystemVersion)

+ (NSInteger)numbericOSVersion {
    NSString *OSVersion = [[UIDevice currentDevice] systemVersion];
    NSArray *OSVersionArr = [OSVersion componentsSeparatedByString:@"."];
    
    NSInteger numbericOSVersion = 0;
    NSInteger pos = 0;
    
    while ([OSVersionArr count] > pos && pos < 3) {
        numbericOSVersion += ([[OSVersionArr objectAtIndex:pos] integerValue] * pow(10, (4 - pos * 2)));
        pos++;
    }
    
    return numbericOSVersion;
}

+ (NSComparisonResult)compareSystemVersion:(NSString *)currentVersion toVersion:(NSString *)targetVersion {
    return [currentVersion compare:targetVersion options:NSNumericSearch];
}

+ (BOOL)isCurrentSystemAtLeastVersion:(NSString *)targetVersion {
    return [Helper compareSystemVersion:[[UIDevice currentDevice] systemVersion] toVersion:targetVersion] == NSOrderedSame || [Helper compareSystemVersion:[[UIDevice currentDevice] systemVersion] toVersion:targetVersion] == NSOrderedDescending;
}

+ (BOOL)isCurrentSystemLowerThanVersion:(NSString *)targetVersion {
    return [Helper compareSystemVersion:[[UIDevice currentDevice] systemVersion] toVersion:targetVersion] == NSOrderedAscending;
}

@end

@implementation Helper

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [Helper sharedInstance];// 确保内部的变量、notification 都正确配置
    });
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static Helper *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
        // 先设置默认值，不然可能变量的指针地址错误
        instance.keyboardVisible = NO;
        instance.lastKeyboardHeight = 0;
        instance.orientationBeforeChangingByHelper = UIDeviceOrientationUnknown;
        
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        // YJX_TODO [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(handleAppSizeWillChange:) name:SWAppSizeWillChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(handleDeviceOrientationNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (void)dealloc {
    // Helper 若干个分类里有用到消息监听，所以在 dealloc 的时候注销一下
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

static NSMutableSet<NSString *> *executedIdentifiers;
+ (BOOL)executeBlock:(void (NS_NOESCAPE ^)(void))block oncePerIdentifier:(NSString *)identifier {
    if (!block || identifier.length <= 0) return NO;
    @synchronized (self) {
        if (!executedIdentifiers) {
            executedIdentifiers = NSMutableSet.new;
        }
        if (![executedIdentifiers containsObject:identifier]) {
            [executedIdentifiers addObject:identifier];
            block();
            return YES;
        }
        return NO;
    }
}

+ (CALayerContentsGravity)layerContentsGravityWithContentMode:(UIViewContentMode)contentMode {
    NSDictionary<NSNumber *, CALayerContentsGravity> *relationship = @{
        @(UIViewContentModeScaleToFill):        kCAGravityResize,
        @(UIViewContentModeScaleAspectFit):     kCAGravityResizeAspect,
        @(UIViewContentModeScaleAspectFill):    kCAGravityResizeAspectFill,
        @(UIViewContentModeCenter):             kCAGravityCenter,
        @(UIViewContentModeTop):                kCAGravityBottom,
        @(UIViewContentModeBottom):             kCAGravityTop,
        @(UIViewContentModeLeft):               kCAGravityLeft,
        @(UIViewContentModeRight):              kCAGravityRight,
        @(UIViewContentModeTopLeft):            kCAGravityBottomLeft,
        @(UIViewContentModeTopRight):           kCAGravityBottomRight,
        @(UIViewContentModeBottomLeft):         kCAGravityTopLeft,
        @(UIViewContentModeBottomRight):        kCAGravityTopRight
    };
    return relationship[@(contentMode)] ?: kCAGravityCenter;
}

@end

@implementation Helper (Ex_Interface)

SWSynthesizeNSIntegerProperty(orientationBeforeChangingByHelper, setOrientationBeforeChangingByHelper)

- (void)handleDeviceOrientationNotification:(NSNotification *)notification {
    // 如果是由 setValue:forKey: 方式修改方向而走到这个 notification 的话，理论上是不需要重置为 Unknown 的，但因为在 UIViewController (Ex) 那边会再次记录旋转前的值，所以这里就算重置也无所谓
    [Helper sharedInstance].orientationBeforeChangingByHelper = UIDeviceOrientationUnknown;
}

+ (BOOL)rotateToDeviceOrientation:(UIDeviceOrientation)orientation {
    if ([UIDevice currentDevice].orientation == orientation) {
        [UIViewController attemptRotationToDeviceOrientation];
        return NO;
    }
    
    [[UIDevice currentDevice] setValue:@(orientation) forKey:@"orientation"];
    return YES;
}

+ (UIDeviceOrientation)deviceOrientationWithInterfaceOrientationMask:(UIInterfaceOrientationMask)mask {
    if ((mask & UIInterfaceOrientationMaskAll) == UIInterfaceOrientationMaskAll) {
        return [UIDevice currentDevice].orientation;
    }
    if ((mask & UIInterfaceOrientationMaskAllButUpsideDown) == UIInterfaceOrientationMaskAllButUpsideDown) {
        return [UIDevice currentDevice].orientation;
    }
    if ((mask & UIInterfaceOrientationMaskPortrait) == UIInterfaceOrientationMaskPortrait) {
        return UIDeviceOrientationPortrait;
    }
    if ((mask & UIInterfaceOrientationMaskLandscape) == UIInterfaceOrientationMaskLandscape) {
        return [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft ? UIDeviceOrientationLandscapeLeft : UIDeviceOrientationLandscapeRight;
    }
    if ((mask & UIInterfaceOrientationMaskLandscapeLeft) == UIInterfaceOrientationMaskLandscapeLeft) {
        return UIDeviceOrientationLandscapeRight;
    }
    if ((mask & UIInterfaceOrientationMaskLandscapeRight) == UIInterfaceOrientationMaskLandscapeRight) {
        return UIDeviceOrientationLandscapeLeft;
    }
    if ((mask & UIInterfaceOrientationMaskPortraitUpsideDown) == UIInterfaceOrientationMaskPortraitUpsideDown) {
        return UIDeviceOrientationPortraitUpsideDown;
    }
    return [UIDevice currentDevice].orientation;
}

+ (BOOL)interfaceOrientationMask:(UIInterfaceOrientationMask)mask containsDeviceOrientation:(UIDeviceOrientation)deviceOrientation {
    if (deviceOrientation == UIDeviceOrientationUnknown) {
        return YES;// YES 表示不用额外处理
    }
    
    if ((mask & UIInterfaceOrientationMaskAll) == UIInterfaceOrientationMaskAll) {
        return YES;
    }
    if ((mask & UIInterfaceOrientationMaskAllButUpsideDown) == UIInterfaceOrientationMaskAllButUpsideDown) {
        return UIInterfaceOrientationPortraitUpsideDown != deviceOrientation;
    }
    if ((mask & UIInterfaceOrientationMaskPortrait) == UIInterfaceOrientationMaskPortrait) {
        return UIInterfaceOrientationPortrait == deviceOrientation;
    }
    if ((mask & UIInterfaceOrientationMaskLandscape) == UIInterfaceOrientationMaskLandscape) {
        return UIInterfaceOrientationLandscapeLeft == deviceOrientation || UIInterfaceOrientationLandscapeRight == deviceOrientation;
    }
    if ((mask & UIInterfaceOrientationMaskLandscapeLeft) == UIInterfaceOrientationMaskLandscapeLeft) {
        return UIInterfaceOrientationLandscapeLeft == deviceOrientation;
    }
    if ((mask & UIInterfaceOrientationMaskLandscapeRight) == UIInterfaceOrientationMaskLandscapeRight) {
        return UIInterfaceOrientationLandscapeRight == deviceOrientation;
    }
    if ((mask & UIInterfaceOrientationMaskPortraitUpsideDown) == UIInterfaceOrientationMaskPortraitUpsideDown) {
        return UIInterfaceOrientationPortraitUpsideDown == deviceOrientation;
    }
    
    return YES;
}

+ (BOOL)interfaceOrientationMask:(UIInterfaceOrientationMask)mask containsInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return [self interfaceOrientationMask:mask containsDeviceOrientation:(UIDeviceOrientation)interfaceOrientation];
}

+ (CGFloat)angleForTransformWithInterfaceOrientation:(UIInterfaceOrientation)orientation {
    CGFloat angle;
    switch (orientation)
    {
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = -M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI_2;
            break;
        default:
            angle = 0.0;
            break;
    }
    return angle;
}

+ (CGAffineTransform)transformForCurrentInterfaceOrientation {
    return [Helper transformWithInterfaceOrientation:UIApplication.sharedApplication.statusBarOrientation];
}

+ (CGAffineTransform)transformWithInterfaceOrientation:(UIInterfaceOrientation)orientation {
    CGFloat angle = [Helper angleForTransformWithInterfaceOrientation:orientation];
    return CGAffineTransformMakeRotation(angle);
}
@end
