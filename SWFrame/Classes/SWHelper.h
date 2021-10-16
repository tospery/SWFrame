//
//  SWHelper.h
//  SWFrame
//
//  Created by liaoya on 2021/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWHelper : NSObject

+ (instancetype)sharedInstance;

@end

@interface SWHelper (Bundle)

/// 获取 SWFrame.framework Images.xcassets 内的图片资源
/// @param name 图片名
+ (nullable UIImage *)imageWithName:(NSString *)name;

@end

@interface SWHelper (UIGraphic)

/// 获取一像素的大小
@property(class, nonatomic, readonly) CGFloat pixelOne;

/// 判断size是否超出范围
+ (void)inspectContextSize:(CGSize)size;

/// context是否合法
+ (BOOL)inspectContextIfInvalidated:(CGContextRef)context;

@end

@interface SWHelper (Device)

/// 如 iPhone12,5、iPad6,8
/// @NEW_DEVICE_CHECKER
@property(class, nonatomic, readonly) NSString *deviceModel;

/// 如 iPhone 11 Pro Max、iPad Pro (12.9 inch)，如果是模拟器，会在后面带上“ Simulator”字样。
/// @NEW_DEVICE_CHECKER
@property(class, nonatomic, readonly) NSString *deviceName;

@property(class, nonatomic, readonly) BOOL isIPad;
@property(class, nonatomic, readonly) BOOL isIPod;
@property(class, nonatomic, readonly) BOOL isIPhone;
@property(class, nonatomic, readonly) BOOL isSimulator;
@property(class, nonatomic, readonly) BOOL isMac;

/// 带物理凹槽的刘海屏或者使用 Home Indicator 类型的设备
/// @NEW_DEVICE_CHECKER
@property(class, nonatomic, readonly) BOOL isNotchedScreen;

/// 将屏幕分为普通和紧凑两种，这个方法用于判断普通屏幕（也即大屏幕）。
/// @note 注意，这里普通/紧凑的标准是 QMUI 自行制定的，与系统 UITraitCollection.horizontalSizeClass/verticalSizeClass 的值无关。只要是通常意义上的“大屏幕手机”（例如 Plus 系列）都会被视为 Regular Screen。
/// @NEW_DEVICE_CHECKER
@property(class, nonatomic, readonly) BOOL isRegularScreen;

/// iPhone 12 Pro Max
@property(class, nonatomic, readonly) BOOL is67InchScreen;

/// iPhone XS Max / 11 Pro Max
@property(class, nonatomic, readonly) BOOL is65InchScreen;

/// iPhone 12 / 12 Pro
@property(class, nonatomic, readonly) BOOL is61InchScreenAndiPhone12;

/// iPhone XR / 11
@property(class, nonatomic, readonly) BOOL is61InchScreen;

/// iPhone X / XS / 11Pro
@property(class, nonatomic, readonly) BOOL is58InchScreen;

/// iPhone 8 Plus
@property(class, nonatomic, readonly) BOOL is55InchScreen;

/// iPhone 12 mini
@property(class, nonatomic, readonly) BOOL is54InchScreen;

/// iPhone 8
@property(class, nonatomic, readonly) BOOL is47InchScreen;

/// iPhone 5
@property(class, nonatomic, readonly) BOOL is40InchScreen;

/// iPhone 4
@property(class, nonatomic, readonly) BOOL is35InchScreen;

@property(class, nonatomic, readonly) CGSize screenSizeFor67Inch;
@property(class, nonatomic, readonly) CGSize screenSizeFor65Inch;
@property(class, nonatomic, readonly) CGSize screenSizeFor61InchAndiPhone12;
@property(class, nonatomic, readonly) CGSize screenSizeFor61Inch;
@property(class, nonatomic, readonly) CGSize screenSizeFor58Inch;
@property(class, nonatomic, readonly) CGSize screenSizeFor55Inch;
@property(class, nonatomic, readonly) CGSize screenSizeFor54Inch;
@property(class, nonatomic, readonly) CGSize screenSizeFor47Inch;
@property(class, nonatomic, readonly) CGSize screenSizeFor40Inch;
@property(class, nonatomic, readonly) CGSize screenSizeFor35Inch;

@property(class, nonatomic, readonly) CGFloat preferredLayoutAsSimilarScreenWidthForIPad;

/// 用于获取 isNotchedScreen 设备的 insets，注意对于 iPad Pro 11-inch 这种无刘海凹槽但却有使用 Home Indicator 的设备，它的 top 返回0，bottom 返回 safeAreaInsets.bottom 的值
/// @NEW_DEVICE_CHECKER
@property(class, nonatomic, readonly) UIEdgeInsets safeAreaInsetsForDeviceWithNotch;

/// 判断当前设备是否高性能设备，只会判断一次，以后都直接读取结果，所以没有性能问题
@property(class, nonatomic, readonly) BOOL isHighPerformanceDevice;

/// 系统设置里是否开启了“放大显示-试图-放大”，支持放大模式的 iPhone 设备可在官方文档中查询 https://support.apple.com/zh-cn/guide/iphone/iphd6804774e/ios
/// @NEW_DEVICE_CHECKER
@property(class, nonatomic, readonly) BOOL isZoomedMode;

/**
 在 iPad 分屏模式下可获得实际运行区域的窗口大小，如需适配 iPad 分屏，建议用这个方法来代替 [UIScreen mainScreen].bounds.size
 @return 应用运行的窗口大小
 */
@property(class, nonatomic, readonly) CGSize applicationSize;

@end

@interface SWHelper (SystemVersion)
+ (NSInteger)numbericOSVersion;
+ (NSComparisonResult)compareSystemVersion:(nonnull NSString *)currentVersion toVersion:(nonnull NSString *)targetVersion;
+ (BOOL)isCurrentSystemAtLeastVersion:(nonnull NSString *)targetVersion;
+ (BOOL)isCurrentSystemLowerThanVersion:(nonnull NSString *)targetVersion;
@end

NS_ASSUME_NONNULL_END
