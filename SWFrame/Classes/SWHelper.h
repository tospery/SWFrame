//
//  SWHelper.h
//  SWFrame
//
//  Created by liaoya on 2021/4/19.
//

#import <Foundation/Foundation.h>
#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWHelper : NSObject
@property(nonatomic, assign, readonly) BOOL isDebug;
@property(nonatomic, assign, readonly) CGFloat toolBarHeight;
@property(nonatomic, assign, readonly) CGFloat tabBarHeight;
@property(nonatomic, assign, readonly) CGFloat statusBarHeight;
@property(nonatomic, assign, readonly) CGFloat statusBarHeightConstant;
@property(nonatomic, assign, readonly) CGFloat navigationBarHeight;
@property(nonatomic, assign, readonly) CGFloat navigationContentTop;
@property(nonatomic, assign, readonly) CGFloat navigationContentTopConstant;

+ (instancetype)sharedInstance;

@end

//inline BOOL
//isDebug() {
//    return IS_DEBUG;
//}
//
//inline CGFloat
//statusBarHeight() {
//    return StatusBarHeight;
//}
//
//inline CGFloat
//statusBarHeightConstant() {
//    return StatusBarHeightConstant;
//}
//
//inline CGFloat
//navigationBarHeight() {
//    return NavigationBarHeight;
//}
//
//inline CGFloat
//navigationContentTop() {
//    return NavigationContentTop;
//}
//
//inline CGFloat
//navigationContentTopConstant() {
//    return NavigationContentTopConstant;
//}
//
//inline CGFloat
//tabBarHeight() {
//    return TabBarHeight;
//}
//
//inline CGFloat
//toolBarHeight() {
//    return ToolBarHeight;
//}

NS_ASSUME_NONNULL_END
