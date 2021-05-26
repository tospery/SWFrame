//
//  CALayer+Ex.m
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/26.
//

#import "CALayer+Ex.h"
#import "SWFDefines.h"
#import "SWFRuntime.h"
#import "UIView+Ex.h"
// #import "UIColor+SWF.h" // YJX_TODO

@interface CALayer ()

@property(nonatomic, assign) float swf_speedBeforePause;

@end

@implementation CALayer (Ex)

SWFSynthesizeFloatProperty(swf_speedBeforePause, setSwf_speedBeforePause)
SWFSynthesizeCGFloatProperty(swf_originCornerRadius, setSwf_originCornerRadius)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 由于其他方法需要通过调用 swflayer_setCornerRadius: 来执行 swizzle 前的实现，所以这里暂时用 ExchangeImplementations
        ExchangeImplementations([CALayer class], @selector(setCornerRadius:), @selector(swflayer_setCornerRadius:));
        
        ExtendImplementationOfNonVoidMethodWithoutArguments([CALayer class], @selector(init), CALayer *, ^CALayer *(CALayer *selfObject, CALayer *originReturnValue) {
            selfObject.swf_speedBeforePause = selfObject.speed;
            selfObject.swf_maskedCorners = SWFLayerAllCorner;
            return originReturnValue;
        });
        
        OverrideImplementation([CALayer class], @selector(setBounds:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(CALayer *selfObject, CGRect bounds) {
                
                // 对非法的 bounds，Debug 下中 assert，Release 下会将其中的 NaN 改为 0，避免 crash
                if (CGRectIsNaN(bounds)) {
#ifdef DEBUG
                    NSLog(@"【CALayer (Ex)】%@ setBounds:%@，参数包含 NaN，已被拦截并处理为 0。%@", selfObject, NSStringFromCGRect(bounds), [NSThread callStackSymbols]);
#endif
                    if (!IS_DEBUG) {
                        bounds = CGRectSafeValue(bounds);
                    } else {
                        NSAssert(NO, @"CALayer setBounds: 出现 NaN");
                    }
                }
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGRect);
                originSelectorIMP = (void (*)(id, SEL, CGRect))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, bounds);
            };
        });
        
        OverrideImplementation([CALayer class], @selector(setPosition:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(CALayer *selfObject, CGPoint position) {
                
                // 对非法的 position，Debug 下中 assert，Release 下会将其中的 NaN 改为 0，避免 crash
                if (isnan(position.x) || isnan(position.y)) {
#ifdef DEBUG
                    NSLog(@"【CALayer (Ex)】%@ setPosition:%@，参数包含 NaN，已被拦截并处理为 0。%@", selfObject, NSStringFromCGPoint(position), [NSThread callStackSymbols]);
#endif
                    if (!IS_DEBUG) {
                        position = CGPointMake(CGFloatSafeValue(position.x), CGFloatSafeValue(position.y));
                    } else {
                        NSAssert(NO, @"CALayer setPosition: 出现 NaN");
                    }
                }
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGPoint);
                originSelectorIMP = (void (*)(id, SEL, CGPoint))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, position);
            };
        });
    });
}

- (BOOL)swf_isRootLayerOfView {
    return [self.delegate isKindOfClass:[UIView class]] && ((UIView *)self.delegate).layer == self;
}

- (void)swflayer_setCornerRadius:(CGFloat)cornerRadius {
    BOOL cornerRadiusChanged = flat(self.swf_originCornerRadius) != flat(cornerRadius);// flat 处理，避免浮点精度问题
    self.swf_originCornerRadius = cornerRadius;
    if (@available(iOS 11, *)) {
        [self swflayer_setCornerRadius:cornerRadius];
    } else {
        if (self.swf_maskedCorners && ![self hasFourCornerRadius]) {
            [self swflayer_setCornerRadius:0];
        } else {
            [self swflayer_setCornerRadius:cornerRadius];
        }
        if (cornerRadiusChanged) {
            // 需要刷新mask
            if ([NSThread isMainThread]) {
                [self setNeedsLayout];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setNeedsLayout];
                });
            }
        }
    }
    if (cornerRadiusChanged) {
        // 需要刷新border
        if ([self.delegate respondsToSelector:@selector(layoutSublayersOfLayer:)]) {
            UIView *view = (UIView *)self.delegate;
            if (view.swf_borderPosition > 0 && view.swf_borderWidth > 0) {
                [view.swf_borderLayer setNeedsLayout];// 直接调用 layer 的 setNeedsLayout，没有线程限制，如果通过 view 调用则需要在主线程才行
            }
        }
    }
}

static char kAssociatedObjectKey_pause;
- (void)setSwf_pause:(BOOL)swf_pause {
    if (swf_pause == self.swf_pause) {
        return;
    }
    if (swf_pause) {
        self.swf_speedBeforePause = self.speed;
        CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
        self.speed = 0;
        self.timeOffset = pausedTime;
    } else {
        CFTimeInterval pausedTime = self.timeOffset;
        self.speed = self.swf_speedBeforePause;
        self.timeOffset = 0;
        self.beginTime = 0;
        CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.beginTime = timeSincePause;
    }
    objc_setAssociatedObject(self, &kAssociatedObjectKey_pause, @(swf_pause), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)swf_pause {
    return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_pause)) boolValue];
}

static char kAssociatedObjectKey_maskedCorners;
- (void)setSwf_maskedCorners:(SWFCornerMask)swf_maskedCorners {
    BOOL maskedCornersChanged = swf_maskedCorners != self.swf_maskedCorners;
    objc_setAssociatedObject(self, &kAssociatedObjectKey_maskedCorners, @(swf_maskedCorners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (@available(iOS 11, *)) {
        self.maskedCorners = (CACornerMask)swf_maskedCorners;
    } else {
        if (swf_maskedCorners && ![self hasFourCornerRadius]) {
            [self swflayer_setCornerRadius:0];
        }
        if (maskedCornersChanged) {
            // 需要刷新mask
            if ([NSThread isMainThread]) {
                [self setNeedsLayout];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setNeedsLayout];
                });
            }
        }
    }
    if (maskedCornersChanged) {
        // 需要刷新border
        if ([self.delegate respondsToSelector:@selector(layoutSublayersOfLayer:)]) {
            UIView *view = (UIView *)self.delegate;
            if (view.swf_borderPosition > 0 && view.swf_borderWidth > 0) {
                [view.swf_borderLayer setNeedsLayout];// 直接调用 layer 的 setNeedsLayout，没有线程限制，如果通过 view 调用则需要在主线程才行
            }
        }
    }
}

- (SWFCornerMask)swf_maskedCorners {
    return [objc_getAssociatedObject(self, &kAssociatedObjectKey_maskedCorners) unsignedIntegerValue];
}

- (void)swf_sendSublayerToBack:(CALayer *)sublayer {
    [self insertSublayer:sublayer atIndex:0];
}

- (void)swf_bringSublayerToFront:(CALayer *)sublayer {
    [self insertSublayer:sublayer atIndex:(unsigned)self.sublayers.count];
}

- (void)swf_removeDefaultAnimations {
    NSMutableDictionary<NSString *, id<CAAction>> *actions = @{NSStringFromSelector(@selector(bounds)): [NSNull null],
                                                               NSStringFromSelector(@selector(position)): [NSNull null],
                                                               NSStringFromSelector(@selector(zPosition)): [NSNull null],
                                                               NSStringFromSelector(@selector(anchorPoint)): [NSNull null],
                                                               NSStringFromSelector(@selector(anchorPointZ)): [NSNull null],
                                                               NSStringFromSelector(@selector(transform)): [NSNull null],
                                                               BeginIgnoreClangWarning(-Wundeclared-selector)
                                                               NSStringFromSelector(@selector(hidden)): [NSNull null],
                                                               NSStringFromSelector(@selector(doubleSided)): [NSNull null],
                                                               EndIgnoreClangWarning
                                                               NSStringFromSelector(@selector(sublayerTransform)): [NSNull null],
                                                               NSStringFromSelector(@selector(masksToBounds)): [NSNull null],
                                                               NSStringFromSelector(@selector(contents)): [NSNull null],
                                                               NSStringFromSelector(@selector(contentsRect)): [NSNull null],
                                                               NSStringFromSelector(@selector(contentsScale)): [NSNull null],
                                                               NSStringFromSelector(@selector(contentsCenter)): [NSNull null],
                                                               NSStringFromSelector(@selector(minificationFilterBias)): [NSNull null],
                                                               NSStringFromSelector(@selector(backgroundColor)): [NSNull null],
                                                               NSStringFromSelector(@selector(cornerRadius)): [NSNull null],
                                                               NSStringFromSelector(@selector(borderWidth)): [NSNull null],
                                                               NSStringFromSelector(@selector(borderColor)): [NSNull null],
                                                               NSStringFromSelector(@selector(opacity)): [NSNull null],
                                                               NSStringFromSelector(@selector(compositingFilter)): [NSNull null],
                                                               NSStringFromSelector(@selector(filters)): [NSNull null],
                                                               NSStringFromSelector(@selector(backgroundFilters)): [NSNull null],
                                                               NSStringFromSelector(@selector(shouldRasterize)): [NSNull null],
                                                               NSStringFromSelector(@selector(rasterizationScale)): [NSNull null],
                                                               NSStringFromSelector(@selector(shadowColor)): [NSNull null],
                                                               NSStringFromSelector(@selector(shadowOpacity)): [NSNull null],
                                                               NSStringFromSelector(@selector(shadowOffset)): [NSNull null],
                                                               NSStringFromSelector(@selector(shadowRadius)): [NSNull null],
                                                               NSStringFromSelector(@selector(shadowPath)): [NSNull null]}.mutableCopy;
    
    if (@available(iOS 11.0, *)) {
        [actions addEntriesFromDictionary:@{NSStringFromSelector(@selector(maskedCorners)): [NSNull null]}];
    }
    
    if ([self isKindOfClass:[CAShapeLayer class]]) {
        [actions addEntriesFromDictionary:@{NSStringFromSelector(@selector(path)): [NSNull null],
                                            NSStringFromSelector(@selector(fillColor)): [NSNull null],
                                            NSStringFromSelector(@selector(strokeColor)): [NSNull null],
                                            NSStringFromSelector(@selector(strokeStart)): [NSNull null],
                                            NSStringFromSelector(@selector(strokeEnd)): [NSNull null],
                                            NSStringFromSelector(@selector(lineWidth)): [NSNull null],
                                            NSStringFromSelector(@selector(miterLimit)): [NSNull null],
                                            NSStringFromSelector(@selector(lineDashPhase)): [NSNull null]}];
    }
    
    if ([self isKindOfClass:[CAGradientLayer class]]) {
        [actions addEntriesFromDictionary:@{NSStringFromSelector(@selector(colors)): [NSNull null],
                                            NSStringFromSelector(@selector(locations)): [NSNull null],
                                            NSStringFromSelector(@selector(startPoint)): [NSNull null],
                                            NSStringFromSelector(@selector(endPoint)): [NSNull null]}];
    }
    
    self.actions = actions;
}

+ (void)swf_performWithoutAnimation:(void (NS_NOESCAPE ^)(void))actionsWithoutAnimation {
    if (!actionsWithoutAnimation) return;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    actionsWithoutAnimation();
    [CATransaction commit];
}

+ (CAShapeLayer *)swf_separatorDashLayerWithLineLength:(NSInteger)lineLength
                                            lineSpacing:(NSInteger)lineSpacing
                                              lineWidth:(CGFloat)lineWidth
                                              lineColor:(CGColorRef)lineColor
                                           isHorizontal:(BOOL)isHorizontal {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = UIColorMakeWithRGBA(255, 255, 255, 0).CGColor;
    layer.strokeColor = lineColor;
    layer.lineWidth = lineWidth;
    layer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInteger:lineLength], [NSNumber numberWithInteger:lineSpacing], nil];
    layer.masksToBounds = YES;
    
    CGMutablePathRef path = CGPathCreateMutable();
    if (isHorizontal) {
        CGPathMoveToPoint(path, NULL, 0, lineWidth / 2);
        CGPathAddLineToPoint(path, NULL, SCREEN_WIDTH, lineWidth / 2);
    } else {
        CGPathMoveToPoint(path, NULL, lineWidth / 2, 0);
        CGPathAddLineToPoint(path, NULL, lineWidth / 2, SCREEN_HEIGHT);
    }
    layer.path = path;
    CGPathRelease(path);
    
    return layer;
}

+ (CAShapeLayer *)swf_separatorDashLayerInHorizontal {
    CAShapeLayer *layer = [CAShapeLayer swf_separatorDashLayerWithLineLength:2 lineSpacing:2 lineWidth:PixelOne lineColor:UIColorMake(17, 17, 17).CGColor isHorizontal:YES];
    return layer;
}

+ (CAShapeLayer *)swf_separatorDashLayerInVertical {
    CAShapeLayer *layer = [CAShapeLayer swf_separatorDashLayerWithLineLength:2 lineSpacing:2 lineWidth:PixelOne lineColor:UIColorMake(17, 17, 17).CGColor isHorizontal:NO];
    return layer;
}

+ (CALayer *)swf_separatorLayer {
    CALayer *layer = [CALayer layer];
    [layer swf_removeDefaultAnimations];
    layer.backgroundColor = UIColorMake(222, 224, 226).CGColor;
    layer.frame = CGRectMake(0, 0, 0, PixelOne);
    return layer;
}

+ (CALayer *)swf_separatorLayerForTableView {
    CALayer *layer = [self swf_separatorLayer];
    layer.backgroundColor = UIColorMake(222, 224, 226).CGColor;
    return layer;
}

- (BOOL)hasFourCornerRadius {
    return (self.swf_maskedCorners & SWFLayerMinXMinYCorner) == SWFLayerMinXMinYCorner &&
           (self.swf_maskedCorners & SWFLayerMaxXMinYCorner) == SWFLayerMaxXMinYCorner &&
           (self.swf_maskedCorners & SWFLayerMinXMaxYCorner) == SWFLayerMinXMaxYCorner &&
           (self.swf_maskedCorners & SWFLayerMaxXMaxYCorner) == SWFLayerMaxXMaxYCorner;
}

@end

@implementation UIView (SWF_CornerRadius)

static NSString *kMaskName = @"SWF_CornerRadius_Mask";

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExtendImplementationOfVoidMethodWithoutArguments([CALayer class], @selector(layoutSublayers), ^(CALayer *selfObject) {
            if (@available(iOS 11, *)) {
            } else {
                if (selfObject.mask && ![selfObject.mask.name isEqualToString:kMaskName]) {
                    return;
                }
                if (selfObject.swf_maskedCorners) {
                    if (selfObject.swf_originCornerRadius <= 0 || [selfObject hasFourCornerRadius]) {
                        if (selfObject.mask) {
                            selfObject.mask = nil;
                        }
                    } else {
                        CAShapeLayer *cornerMaskLayer = [CAShapeLayer layer];
                        cornerMaskLayer.name = kMaskName;
                        UIRectCorner rectCorner = 0;
                        if ((selfObject.swf_maskedCorners & SWFLayerMinXMinYCorner) == SWFLayerMinXMinYCorner) {
                            rectCorner |= UIRectCornerTopLeft;
                        }
                        if ((selfObject.swf_maskedCorners & SWFLayerMaxXMinYCorner) == SWFLayerMaxXMinYCorner) {
                            rectCorner |= UIRectCornerTopRight;
                        }
                        if ((selfObject.swf_maskedCorners & SWFLayerMinXMaxYCorner) == SWFLayerMinXMaxYCorner) {
                            rectCorner |= UIRectCornerBottomLeft;
                        }
                        if ((selfObject.swf_maskedCorners & SWFLayerMaxXMaxYCorner) == SWFLayerMaxXMaxYCorner) {
                            rectCorner |= UIRectCornerBottomRight;
                        }
                        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:selfObject.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(selfObject.swf_originCornerRadius, selfObject.swf_originCornerRadius)];
                        cornerMaskLayer.frame = CGRectMakeWithSize(selfObject.bounds.size);
                        cornerMaskLayer.path = path.CGPath;
                        selfObject.mask = cornerMaskLayer;
                    }
                }
            }
        });
    });
}
                
- (BOOL)hasFourCornerRadius {
    return (self.layer.swf_maskedCorners & SWFLayerMinXMinYCorner) == SWFLayerMinXMinYCorner &&
           (self.layer.swf_maskedCorners & SWFLayerMaxXMinYCorner) == SWFLayerMaxXMinYCorner &&
           (self.layer.swf_maskedCorners & SWFLayerMinXMaxYCorner) == SWFLayerMinXMaxYCorner &&
           (self.layer.swf_maskedCorners & SWFLayerMaxXMaxYCorner) == SWFLayerMaxXMaxYCorner;
}

@end

@interface CAShapeLayer (Ex_DynamicColor)

@property(nonatomic, strong) UIColor *qcl_originalFillColor;
@property(nonatomic, strong) UIColor *qcl_originalStrokeColor;

@end

@implementation CAShapeLayer (Ex_DynamicColor)

SWFSynthesizeIdStrongProperty(qcl_originalFillColor, setQcl_originalFillColor)
SWFSynthesizeIdStrongProperty(qcl_originalStrokeColor, setQcl_originalStrokeColor)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        OverrideImplementation([CAShapeLayer class], @selector(setFillColor:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(CAShapeLayer *selfObject, CGColorRef color) {
                
                UIColor *originalColor = [(__bridge id)(color) swf_getBoundObjectForKey:SWFCGColorOriginalColorBindKey];
                selfObject.qcl_originalFillColor = originalColor;
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGColorRef);
                originSelectorIMP = (void (*)(id, SEL, CGColorRef))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, color);
            };
        });
        
        OverrideImplementation([CAShapeLayer class], @selector(setStrokeColor:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(CAShapeLayer *selfObject, CGColorRef color) {
                
                UIColor *originalColor = [(__bridge id)(color) swf_getBoundObjectForKey:SWFCGColorOriginalColorBindKey];
                selfObject.qcl_originalStrokeColor = originalColor;
                
                // call super
                void (*originSelectorIMP)(id, SEL, CGColorRef);
                originSelectorIMP = (void (*)(id, SEL, CGColorRef))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, color);
            };
        });
    });
}

- (void)swf_setNeedsUpdateDynamicStyle {
    [super swf_setNeedsUpdateDynamicStyle];
    
    if (self.qcl_originalFillColor) {
        self.fillColor = self.qcl_originalFillColor.CGColor;
    }
    
    if (self.qcl_originalStrokeColor) {
        self.strokeColor = self.qcl_originalStrokeColor.CGColor;
    }
}

@end

@interface CAGradientLayer (Ex_DynamicColor)

@property(nonatomic, strong) NSArray <UIColor *>* qcl_originalColors;

@end

@implementation CAGradientLayer (Ex_DynamicColor)

SWFSynthesizeIdStrongProperty(qcl_originalColors, setQcl_originalColors)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        OverrideImplementation([CAGradientLayer class], @selector(setColors:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(CAGradientLayer *selfObject, NSArray *colors) {
                
           
                void (*originSelectorIMP)(id, SEL, NSArray *);
                originSelectorIMP = (void (*)(id, SEL, NSArray *))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, colors);
                
                
                __block BOOL hasDynamicColor = NO;
                NSMutableArray *originalColors = [NSMutableArray array];
                [colors enumerateObjectsUsingBlock:^(id color, NSUInteger idx, BOOL * _Nonnull stop) {
                    UIColor *originalColor = [color swf_getBoundObjectForKey:SWFCGColorOriginalColorBindKey];
                    if (originalColor) {
                        hasDynamicColor = YES;
                        [originalColors addObject:originalColor];
                    } else {
                        [originalColors addObject:[UIColor colorWithCGColor:(__bridge CGColorRef _Nonnull)(color)]];
                    }
                }];
                
                if (hasDynamicColor) {
                    selfObject.qcl_originalColors = originalColors;
                } else {
                    selfObject.qcl_originalColors = nil;
                }
                
            };
        });
    });
}

- (void)swf_setNeedsUpdateDynamicStyle {
    [super swf_setNeedsUpdateDynamicStyle];
    
    if (self.qcl_originalColors) {
        NSMutableArray *colors = [NSMutableArray array];
        [self.qcl_originalColors enumerateObjectsUsingBlock:^(UIColor * _Nonnull color, NSUInteger idx, BOOL * _Nonnull stop) {
            [colors addObject:(__bridge id _Nonnull)(color.CGColor)];
        }];
        self.colors = colors;
    }
}

@end
