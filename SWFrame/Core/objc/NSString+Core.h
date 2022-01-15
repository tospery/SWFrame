//
//  NSString+Core.h
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Core)

/// 把当前文本的第一个字符改为大写，其他的字符保持不变，例如 backgroundView.swf_capitalizedString -> BackgroundView（系统的 capitalizedString 会变成 Backgroundview）
@property(nullable, readonly, copy) NSString *swf_capitalizedString;

@end

NS_ASSUME_NONNULL_END
