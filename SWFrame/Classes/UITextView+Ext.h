//
//  UITextView+Ext.h
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Ext)
@property (nonatomic, readonly) UITextView *placeholderTextView NS_SWIFT_NAME(placeholderTextView);

@property (nonatomic, strong, nullable) IBInspectable NSString *placeholder;
@property (nonatomic, strong, nullable) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong, nullable) IBInspectable UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;

@end

NS_ASSUME_NONNULL_END
