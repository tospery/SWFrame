//
//  UIView+Ex.m
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/26.
//

#import "UIView+Ex.h"
#import "SWFDefines.h"
#import "SWFRuntime.h"
#import "CALayer+Ex.h"

@interface CAShapeLayer (Ex)

@property(nonatomic, weak) UIView *_swfbd_targetBorderView;
@end

@implementation UIView (Ex)

SWFSynthesizeIdStrongProperty(swf_borderLayer, setSwf_borderLayer)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ExtendImplementationOfNonVoidMethodWithSingleArgument([UIView class], @selector(initWithFrame:), CGRect, UIView *, ^UIView *(UIView *selfObject, CGRect frame, UIView *originReturnValue) {
            [selfObject _swfbd_setDefaultStyle];
            return originReturnValue;
        });
        
        ExtendImplementationOfNonVoidMethodWithSingleArgument([UIView class], @selector(initWithCoder:), NSCoder *, UIView *, ^UIView *(UIView *selfObject, NSCoder *aDecoder, UIView *originReturnValue) {
            [selfObject _swfbd_setDefaultStyle];
            return originReturnValue;
        });
    });
}

- (void)_swfbd_setDefaultStyle {
    self.swf_borderWidth = PixelOne;
    self.swf_borderColor = UIColorMake(222, 224, 226);
}

- (void)_swfbd_createBorderLayerIfNeeded {
    BOOL shouldShowBorder = self.swf_borderWidth > 0 && self.swf_borderColor && self.swf_borderPosition != SWFViewBorderPositionNone;
    if (!shouldShowBorder) {
        self.swf_borderLayer.hidden = YES;
        return;
    }
    
    [SWFHelper executeBlock:^{
        OverrideImplementation([UIView class], @selector(layoutSublayersOfLayer:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject, CALayer *firstArgv) {
                
                // call super
                void (*originSelectorIMP)(id, SEL, CALayer *);
                originSelectorIMP = (void (*)(id, SEL, CALayer *))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, firstArgv);
                
                if (!selfObject.swf_borderLayer || selfObject.swf_borderLayer.hidden) return;
                selfObject.swf_borderLayer.frame = selfObject.bounds;
                [selfObject.layer swf_bringSublayerToFront:selfObject.swf_borderLayer];
                [selfObject.swf_borderLayer setNeedsLayout];// 把布局刷新逻辑剥离到 layer 内，方便在子线程里直接刷新 layer，如果放在 UIView 内，子线程里就无法主动请求刷新了
            };
        });
    } oncePerIdentifier:@"UIView (Ex) layoutSublayers"];
    
    if (!self.swf_borderLayer) {
        self.swf_borderLayer = [CAShapeLayer layer];
        self.swf_borderLayer._swfbd_targetBorderView = self;
        [self.swf_borderLayer swf_removeDefaultAnimations];
        self.swf_borderLayer.fillColor = UIColorMakeWithRGBA(255, 255, 255, 0).CGColor;
        [self.layer addSublayer:self.swf_borderLayer];
    }
    self.swf_borderLayer.lineWidth = self.swf_borderWidth;
    self.swf_borderLayer.strokeColor = self.swf_borderColor.CGColor;
    self.swf_borderLayer.lineDashPhase = self.swf_dashPhase;
    self.swf_borderLayer.lineDashPattern = self.swf_dashPattern;
    self.swf_borderLayer.hidden = NO;
}

static char kAssociatedObjectKey_borderLocation;
- (void)setSwf_borderLocation:(SWFViewBorderLocation)swf_borderLocation {
    BOOL shouldUpdateLayout = self.swf_borderLocation != swf_borderLocation;
    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderLocation, @(swf_borderLocation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _swfbd_createBorderLayerIfNeeded];
    if (shouldUpdateLayout) {
        [self setNeedsLayout];
    }
}

- (SWFViewBorderLocation)swf_borderLocation {
    return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_borderLocation)) unsignedIntegerValue];
}

static char kAssociatedObjectKey_borderPosition;
- (void)setSwf_borderPosition:(SWFViewBorderPosition)swf_borderPosition {
    BOOL shouldUpdateLayout = self.swf_borderPosition != swf_borderPosition;
    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderPosition, @(swf_borderPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _swfbd_createBorderLayerIfNeeded];
    if (shouldUpdateLayout) {
        [self setNeedsLayout];
    }
}

- (SWFViewBorderPosition)swf_borderPosition {
    return (SWFViewBorderPosition)[objc_getAssociatedObject(self, &kAssociatedObjectKey_borderPosition) unsignedIntegerValue];
}

static char kAssociatedObjectKey_borderWidth;
- (void)setSwf_borderWidth:(CGFloat)swf_borderWidth {
    BOOL shouldUpdateLayout = self.swf_borderWidth != swf_borderWidth;
    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderWidth, @(swf_borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _swfbd_createBorderLayerIfNeeded];
    if (shouldUpdateLayout) {
        [self setNeedsLayout];
    }
}

- (CGFloat)swf_borderWidth {
    return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_borderWidth)) swf_CGFloatValue];
}

static char kAssociatedObjectKey_borderColor;
- (void)setSwf_borderColor:(UIColor *)swf_borderColor {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderColor, swf_borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _swfbd_createBorderLayerIfNeeded];
    [self setNeedsLayout];
}

- (UIColor *)swf_borderColor {
    return (UIColor *)objc_getAssociatedObject(self, &kAssociatedObjectKey_borderColor);
}

static char kAssociatedObjectKey_dashPhase;
- (void)setSwf_dashPhase:(CGFloat)swf_dashPhase {
    BOOL shouldUpdateLayout = self.swf_dashPhase != swf_dashPhase;
    objc_setAssociatedObject(self, &kAssociatedObjectKey_dashPhase, @(swf_dashPhase), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _swfbd_createBorderLayerIfNeeded];
    if (shouldUpdateLayout) {
        [self setNeedsLayout];
    }
}

- (CGFloat)swf_dashPhase {
    return [(NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_dashPhase) swf_CGFloatValue];
}

static char kAssociatedObjectKey_dashPattern;
- (void)setSwf_dashPattern:(NSArray<NSNumber *> *)swf_dashPattern {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_dashPattern, swf_dashPattern, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _swfbd_createBorderLayerIfNeeded];
    [self setNeedsLayout];
}

- (NSArray *)swf_dashPattern {
    return (NSArray<NSNumber *> *)objc_getAssociatedObject(self, &kAssociatedObjectKey_dashPattern);
}

@end

@implementation CAShapeLayer (Ex)
SWFSynthesizeIdWeakProperty(_swfbd_targetBorderView, set_swfbd_targetBorderView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExtendImplementationOfVoidMethodWithoutArguments([CAShapeLayer class], @selector(layoutSublayers), ^(CAShapeLayer *selfObject) {
            if (!selfObject._swfbd_targetBorderView) return;
            
            UIView *view = selfObject._swfbd_targetBorderView;
            CGFloat borderWidth = selfObject.lineWidth;
            
            UIBezierPath *path = [UIBezierPath bezierPath];;
            
            CGFloat (^adjustsLocation)(CGFloat, CGFloat, CGFloat) = ^CGFloat(CGFloat inside, CGFloat center, CGFloat outside) {
                return view.swf_borderLocation == SWFViewBorderLocationInside ? inside : (view.swf_borderLocation == SWFViewBorderLocationCenter ? center : outside);
            };
            
            CGFloat lineOffset = adjustsLocation(borderWidth / 2.0, 0, -borderWidth / 2.0); // 为了像素对齐而做的偏移
            CGFloat lineCapOffset = adjustsLocation(0, borderWidth / 2.0, borderWidth); // 两条相邻的边框连接的位置
            
            BOOL shouldShowTopBorder = (view.swf_borderPosition & SWFViewBorderPositionTop) == SWFViewBorderPositionTop;
            BOOL shouldShowLeftBorder = (view.swf_borderPosition & SWFViewBorderPositionLeft) == SWFViewBorderPositionLeft;
            BOOL shouldShowBottomBorder = (view.swf_borderPosition & SWFViewBorderPositionBottom) == SWFViewBorderPositionBottom;
            BOOL shouldShowRightBorder = (view.swf_borderPosition & SWFViewBorderPositionRight) == SWFViewBorderPositionRight;
            
            UIBezierPath *topPath = [UIBezierPath bezierPath];
            UIBezierPath *leftPath = [UIBezierPath bezierPath];
            UIBezierPath *bottomPath = [UIBezierPath bezierPath];
            UIBezierPath *rightPath = [UIBezierPath bezierPath];
            
            if (view.layer.swf_originCornerRadius > 0) {
                
                CGFloat cornerRadius = view.layer.swf_originCornerRadius;
                
                if (view.layer.swf_maskedCorners) {
                    if ((view.layer.swf_maskedCorners & SWFLayerMinXMinYCorner) == SWFLayerMinXMinYCorner) {
                        [topPath addArcWithCenter:CGPointMake(cornerRadius, cornerRadius) radius:cornerRadius - lineOffset startAngle:1.25 * M_PI endAngle:1.5 * M_PI clockwise:YES];
                        [topPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, lineOffset)];
                        [leftPath addArcWithCenter:CGPointMake(cornerRadius, cornerRadius) radius:cornerRadius - lineOffset startAngle:-0.75 * M_PI endAngle:-1 * M_PI clockwise:NO];
                        [leftPath addLineToPoint:CGPointMake(lineOffset, CGRectGetHeight(selfObject.bounds) - cornerRadius)];
                    } else {
                        [topPath moveToPoint:CGPointMake(shouldShowLeftBorder ? -lineCapOffset : 0, lineOffset)];
                        [topPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, lineOffset)];
                        [leftPath moveToPoint:CGPointMake(lineOffset, shouldShowTopBorder ? -lineCapOffset : 0)];
                        [leftPath addLineToPoint:CGPointMake(lineOffset, CGRectGetHeight(selfObject.bounds) - cornerRadius)];
                    }
                    if ((view.layer.swf_maskedCorners & SWFLayerMinXMaxYCorner) == SWFLayerMinXMaxYCorner) {
                        [leftPath addArcWithCenter:CGPointMake(cornerRadius, CGRectGetHeight(selfObject.bounds) - cornerRadius) radius:cornerRadius - lineOffset startAngle:-1 * M_PI endAngle:-1.25 * M_PI clockwise:NO];
                        [bottomPath addArcWithCenter:CGPointMake(cornerRadius, CGRectGetHeight(selfObject.bounds) - cornerRadius) radius:cornerRadius - lineOffset startAngle:-1.25 * M_PI endAngle:-1.5 * M_PI clockwise:NO];
                        [bottomPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, CGRectGetHeight(selfObject.bounds) - lineOffset)];
                    } else {
                        [leftPath addLineToPoint:CGPointMake(lineOffset, CGRectGetHeight(selfObject.bounds) + (shouldShowBottomBorder ? lineCapOffset : 0))];
                        CGFloat y = CGRectGetHeight(selfObject.bounds) - lineOffset;
                        [bottomPath moveToPoint:CGPointMake(shouldShowLeftBorder ? -lineCapOffset : 0, y)];
                        [bottomPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, y)];
                    }
                    if ((view.layer.swf_maskedCorners & SWFLayerMaxXMaxYCorner) == SWFLayerMaxXMaxYCorner) {
                        [bottomPath addArcWithCenter:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, CGRectGetHeight(selfObject.bounds) - cornerRadius) radius:cornerRadius - lineOffset startAngle:-1.5 * M_PI endAngle:-1.75 * M_PI clockwise:NO];
                        [rightPath addArcWithCenter:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, CGRectGetHeight(selfObject.bounds) - cornerRadius) radius:cornerRadius - lineOffset startAngle:-1.75 * M_PI endAngle:-2 * M_PI clockwise:NO];
                        [rightPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) - lineOffset, cornerRadius)];
                    } else {
                        CGFloat y = CGRectGetHeight(selfObject.bounds) - lineOffset;
                        [bottomPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) + (shouldShowRightBorder ? lineCapOffset : 0), y)];
                        CGFloat x = CGRectGetWidth(selfObject.bounds) - lineOffset;
                        [rightPath moveToPoint:CGPointMake(x, CGRectGetHeight(selfObject.bounds) + (shouldShowBottomBorder ? lineCapOffset : 0))];
                        [rightPath addLineToPoint:CGPointMake(x, cornerRadius)];
                    }
                    if ((view.layer.swf_maskedCorners & SWFLayerMaxXMinYCorner) == SWFLayerMaxXMinYCorner) {
                        [rightPath addArcWithCenter:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, cornerRadius) radius:cornerRadius - lineOffset startAngle:0 * M_PI endAngle:-0.25 * M_PI clockwise:NO];
                        [topPath addArcWithCenter:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, cornerRadius) radius:cornerRadius - lineOffset startAngle:1.5 * M_PI endAngle:1.75 * M_PI clockwise:YES];
                    } else {
                        CGFloat x = CGRectGetWidth(selfObject.bounds) - lineOffset;
                        [rightPath addLineToPoint:CGPointMake(x, shouldShowTopBorder ? -lineCapOffset : 0)];
                        [topPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) + (shouldShowRightBorder ? lineCapOffset : 0), lineOffset)];
                    }
                } else {
                    [topPath addArcWithCenter:CGPointMake(cornerRadius, cornerRadius) radius:cornerRadius - lineOffset startAngle:1.25 * M_PI endAngle:1.5 * M_PI clockwise:YES];
                    [topPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, lineOffset)];
                    [topPath addArcWithCenter:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, cornerRadius) radius:cornerRadius - lineOffset startAngle:1.5 * M_PI endAngle:1.75 * M_PI clockwise:YES];
                    
                    [leftPath addArcWithCenter:CGPointMake(cornerRadius, cornerRadius) radius:cornerRadius - lineOffset startAngle:-0.75 * M_PI endAngle:-1 * M_PI clockwise:NO];
                    [leftPath addLineToPoint:CGPointMake(lineOffset, CGRectGetHeight(selfObject.bounds) - cornerRadius)];
                    [leftPath addArcWithCenter:CGPointMake(cornerRadius, CGRectGetHeight(selfObject.bounds) - cornerRadius) radius:cornerRadius - lineOffset startAngle:-1 * M_PI endAngle:-1.25 * M_PI clockwise:NO];
                    
                    [bottomPath addArcWithCenter:CGPointMake(cornerRadius, CGRectGetHeight(selfObject.bounds) - cornerRadius) radius:cornerRadius - lineOffset startAngle:-1.25 * M_PI endAngle:-1.5 * M_PI clockwise:NO];
                    [bottomPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, CGRectGetHeight(selfObject.bounds) - lineOffset)];
                    [bottomPath addArcWithCenter:CGPointMake(CGRectGetHeight(selfObject.bounds) - cornerRadius, CGRectGetHeight(selfObject.bounds) - cornerRadius) radius:cornerRadius - lineOffset startAngle:-1.5 * M_PI endAngle:-1.75 * M_PI clockwise:NO];
                    
                    [rightPath addArcWithCenter:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, CGRectGetHeight(selfObject.bounds) - cornerRadius) radius:cornerRadius - lineOffset startAngle:-1.75 * M_PI endAngle:-2 * M_PI clockwise:NO];
                    [rightPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) - lineOffset, cornerRadius)];
                    [rightPath addArcWithCenter:CGPointMake(CGRectGetWidth(selfObject.bounds) - cornerRadius, cornerRadius) radius:cornerRadius - lineOffset startAngle:0 * M_PI endAngle:-0.25 * M_PI clockwise:NO];
                }
                
            } else {
                [topPath moveToPoint:CGPointMake(shouldShowLeftBorder ? -lineCapOffset : 0, lineOffset)];
                [topPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) + (shouldShowRightBorder ? lineCapOffset : 0), lineOffset)];
                
                [leftPath moveToPoint:CGPointMake(lineOffset, shouldShowTopBorder ? -lineCapOffset : 0)];
                [leftPath addLineToPoint:CGPointMake(lineOffset, CGRectGetHeight(selfObject.bounds) + (shouldShowBottomBorder ? lineCapOffset : 0))];
                
                CGFloat y = CGRectGetHeight(selfObject.bounds) - lineOffset;
                [bottomPath moveToPoint:CGPointMake(shouldShowLeftBorder ? -lineCapOffset : 0, y)];
                [bottomPath addLineToPoint:CGPointMake(CGRectGetWidth(selfObject.bounds) + (shouldShowRightBorder ? lineCapOffset : 0), y)];
                
                CGFloat x = CGRectGetWidth(selfObject.bounds) - lineOffset;
                [rightPath moveToPoint:CGPointMake(x, CGRectGetHeight(selfObject.bounds) + (shouldShowBottomBorder ? lineCapOffset : 0))];
                [rightPath addLineToPoint:CGPointMake(x, shouldShowTopBorder ? -lineCapOffset : 0)];
            }
            
            if (shouldShowTopBorder && ![topPath isEmpty]) {
                [path appendPath:topPath];
            }
            if (shouldShowLeftBorder && ![leftPath isEmpty]) {
                [path appendPath:leftPath];
            }
            if (shouldShowBottomBorder && ![bottomPath isEmpty]) {
                [path appendPath:bottomPath];
            }
            if (shouldShowRightBorder && ![rightPath isEmpty]) {
                [path appendPath:rightPath];
            }
            
            selfObject.path = path.CGPath;
        });
    });
}
@end

