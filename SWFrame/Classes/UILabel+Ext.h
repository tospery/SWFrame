//
//  UILabel+Ext.h
//  SWFrame
//
//  Created by liaoya on 2020/7/24.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface UILabel (Ext)

+ (CGSize)sizeThatFitsAttributedString:(NSAttributedString *)attributedString
                       withConstraints:(CGSize)size
                limitedToNumberOfLines:(NSUInteger)numberOfLines;

@end
