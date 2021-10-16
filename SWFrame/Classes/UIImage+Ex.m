//
//  UIImage+Ex.m
//  SWFrame
//
//  Created by liaoya on 2021/8/18.
//

#import "UIImage+Ex.h"
#import "Function.h"
#import "UIColor+Ex.h"
#import "SWHelper.h"

#define CGContextInspectSize(size) [SWHelper inspectContextSize:size]
#define CGContextInspectContextReturnVoid(context) if(![SWHelper inspectContextIfInvalidated:context]){return;}

CGRect CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}

@implementation UIImage (Ex)

+ (UIImage *)qmui_imageWithSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale actions:(void (^)(CGContextRef contextRef))actionBlock {
    if (!actionBlock || CGSizeIsEmpty(size)) {
        return nil;
    }
    UIGraphicsImageRendererFormat *format = [[UIGraphicsImageRendererFormat alloc] init];
    format.scale = scale;
    format.opaque = opaque;
    UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:size format:format];
    UIImage *imageOut = [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        CGContextRef context = rendererContext.CGContext;
        CGContextInspectContextReturnVoid(context);
        actionBlock(context);
    }];
    return imageOut;
}

- (BOOL)qmui_opaque {
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipLast
    || alphaInfo == kCGImageAlphaNoneSkipFirst
    || alphaInfo == kCGImageAlphaNone;
    return opaque;
}

+ (UIImage *)qmui_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    size = CGSizeFlatted(size);
    CGContextInspectSize(size);
    
    color = color ? color : UIColor.clearColor;
    BOOL opaque = (cornerRadius == 0.0 && [color qmui_alpha] == 1.0);
    return [UIImage qmui_imageWithSize:size opaque:opaque scale:0 actions:^(CGContextRef contextRef) {
        CGContextSetFillColorWithColor(contextRef, color.CGColor);
        
        if (cornerRadius > 0) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMakeWithSize(size) cornerRadius:cornerRadius];
            [path addClip];
            [path fill];
        } else {
            CGContextFillRect(contextRef, CGRectMakeWithSize(size));
        }
    }];
}


- (UIImage *)qmui_imageWithTintColor:(UIColor *)tintColor {
    // iOS 13 的 imageWithTintColor: 方法里并不会去更新 CGImage，所以通过它更改了图片颜色后再获取到的 CGImage 依然是旧的，因此暂不使用
//    if (@available(iOS 13.0, *)) {
//        return [self imageWithTintColor:tintColor];
//    }
    BOOL opaque = self.qmui_opaque ? tintColor.qmui_alpha >= 1.0 : NO;// 如果图片不透明但 tintColor 半透明，则生成的图片也应该是半透明的
    return [UIImage qmui_imageWithSize:self.size opaque:opaque scale:self.scale actions:^(CGContextRef contextRef) {
        CGContextTranslateCTM(contextRef, 0, self.size.height);
        CGContextScaleCTM(contextRef, 1.0, -1.0);
        if (!opaque) {
            CGContextSetBlendMode(contextRef, kCGBlendModeNormal);
            CGContextClipToMask(contextRef, CGRectMakeWithSize(self.size), self.CGImage);
        }
        CGContextSetFillColorWithColor(contextRef, tintColor.CGColor);
        CGContextFillRect(contextRef, CGRectMakeWithSize(self.size));
    }];
}

- (UIImage *)getGradientImageFromColors:(NSArray *)colors gradientDirection:(GradientDirection)gradientDirection imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientDirection) {
        case GradientDirectionTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientDirectionLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
