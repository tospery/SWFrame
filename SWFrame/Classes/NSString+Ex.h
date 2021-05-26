//
//  NSString+Ex.h
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Ex)
/// 去掉头尾的空白字符
@property(readonly, copy) NSString *sf_trim;

/// 把当前文本的第一个字符改为大写，其他的字符保持不变，例如 backgroundView.sf_capitalizedString -> BackgroundView（系统的 capitalizedString 会变成 Backgroundview）
@property(nullable, readonly, copy) NSString *sf_capitalizedString;

/**
 用正则表达式匹配字符串，将匹配到的第一个结果返回，大小写不敏感

 @param pattern 正则表达式
 @return 匹配到的第一个结果，如果没有匹配成功则返回 nil
 */
- (NSString *)sf_stringMatchedByPattern:(NSString *)pattern;

@end

NS_ASSUME_NONNULL_END
