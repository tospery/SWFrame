//
//  SWHelper.h
//  SWFrame
//
//  Created by liaoya on 2021/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWHelper : NSObject
@property (nonatomic, assign, readonly) CGFloat toolBarHeight;
@property (nonatomic, assign, readonly) CGFloat tabBarHeight;
@property (nonatomic, assign, readonly) CGFloat statusBarHeight;
@property (nonatomic, assign, readonly) CGFloat statusBarHeightConstant;
@property (nonatomic, assign, readonly) CGFloat navigationBarHeight;
@property (nonatomic, assign, readonly) CGFloat navigationContentTop;
@property (nonatomic, assign, readonly) CGFloat navigationContentTopConstant;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
