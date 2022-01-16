////
////  UIView+SWBorder.m
////  SWFrame
////
////  Created by liaoya on 2022/1/13.
////
//
//#import "UIView+SWBorder.h"
//#import "Lab.h"
//#import "Runtime.h"
//#import "SWHelper.h"
//#import "CALayer+Reactor.h"
//
//@interface SWFBorderLayer : CAShapeLayer
//
//@property(nonatomic, weak) UIView *_swfbd_targetBorderView;
//@end
//
//@implementation UIView (SWBorder)
//
//SWFSynthesizeIdStrongProperty(swf_borderLayer, setSwf_borderLayer)
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
//        ExtendImplementationOfNonVoidMethodWithSingleArgument([UIView class], @selector(initWithFrame:), CGRect, UIView *, ^UIView *(UIView *selfObject, CGRect frame, UIView *originReturnValue) {
//            [selfObject _swfbd_setDefaultStyle];
//            return originReturnValue;
//        });
//
//        ExtendImplementationOfNonVoidMethodWithSingleArgument([UIView class], @selector(initWithCoder:), NSCoder *, UIView *, ^UIView *(UIView *selfObject, NSCoder *aDecoder, UIView *originReturnValue) {
//            [selfObject _swfbd_setDefaultStyle];
//            return originReturnValue;
//        });
//    });
//}
//
//- (void)_swfbd_setDefaultStyle {
//    self.swf_borderWidth = 1.0 / UIScreen.mainScreen.scale;
//    self.swf_borderColor = UIColor.grayColor;
//}
//
//- (void)_swfbd_createBorderLayerIfNeeded {
//    BOOL shouldShowBorder = self.swf_borderWidth > 0 && self.swf_borderColor && self.swf_borderPosition != SWFViewBorderPositionNone;
//    if (!shouldShowBorder) {
//        self.swf_borderLayer.hidden = YES;
//        return;
//    }
//
//    [SWHelper executeBlock:^{
//        OverrideImplementation([UIView class], @selector(layoutSublayersOfLayer:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
//            return ^(UIView *selfObject, CALayer *firstArgv) {
//
//                // call super
//                void (*originSelectorIMP)(id, SEL, CALayer *);
//                originSelectorIMP = (void (*)(id, SEL, CALayer *))originalIMPProvider();
//                originSelectorIMP(selfObject, originCMD, firstArgv);
//
//                if (!selfObject.swf_borderLayer || selfObject.swf_borderLayer.hidden) return;
//                selfObject.swf_borderLayer.frame = selfObject.bounds;
//                [selfObject.layer swf_bringSublayerToFront:selfObject.swf_borderLayer];
//                [selfObject.swf_borderLayer setNeedsLayout];// 把布局刷新逻辑剥离到 layer 内，方便在子线程里直接刷新 layer，如果放在 UIView 内，子线程里就无法主动请求刷新了
//            };
//        });
//    } oncePerIdentifier:@"UIView (SWFBorder) layoutSublayers"];
//
//    if (!self.swf_borderLayer) {
//        SWFBorderLayer *layer = [SWFBorderLayer layer];
//        layer._swfbd_targetBorderView = self;
//        [layer swf_removeDefaultAnimations];
//        layer.fillColor = UIColor.clearColor.CGColor;
//        [self.layer addSublayer:layer];
//        self.swf_borderLayer = layer;
//    }
//    self.swf_borderLayer.lineWidth = self.swf_borderWidth;
//    self.swf_borderLayer.strokeColor = self.swf_borderColor.CGColor;
//    self.swf_borderLayer.lineDashPhase = self.swf_dashPhase;
//    self.swf_borderLayer.lineDashPattern = self.swf_dashPattern;
//    self.swf_borderLayer.hidden = NO;
//}
//
//static char kAssociatedObjectKey_borderLocation;
//- (void)setSwf_borderLocation:(SWFViewBorderLocation)swf_borderLocation {
//    BOOL valueChanged = self.swf_borderLocation != swf_borderLocation;
//    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderLocation, @(swf_borderLocation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self _swfbd_createBorderLayerIfNeeded];
//    if (valueChanged && self.swf_borderLayer && !self.swf_borderLayer.hidden) {
//        [self setNeedsLayout];
//    }
//}
//
//- (SWFViewBorderLocation)swf_borderLocation {
//    return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_borderLocation)) unsignedIntegerValue];
//}
//
//static char kAssociatedObjectKey_borderPosition;
//- (void)setSwf_borderPosition:(SWFViewBorderPosition)swf_borderPosition {
//    BOOL valueChanged = self.swf_borderPosition != swf_borderPosition;
//    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderPosition, @(swf_borderPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self _swfbd_createBorderLayerIfNeeded];
//    if (valueChanged && self.swf_borderLayer && !self.swf_borderLayer.hidden) {
//        [self setNeedsLayout];
//    }
//}
//
//- (SWFViewBorderPosition)swf_borderPosition {
//    return (SWFViewBorderPosition)[objc_getAssociatedObject(self, &kAssociatedObjectKey_borderPosition) unsignedIntegerValue];
//}
//
//static char kAssociatedObjectKey_borderWidth;
//- (void)setSwf_borderWidth:(CGFloat)swf_borderWidth {
//    BOOL valueChanged = self.swf_borderWidth != swf_borderWidth;
//    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderWidth, @(swf_borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self _swfbd_createBorderLayerIfNeeded];
//    if (valueChanged && self.swf_borderLayer && !self.swf_borderLayer.hidden) {
//        [self setNeedsLayout];
//    }
//}
//
//- (CGFloat)swf_borderWidth {
//    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_borderWidth);
//#if CGFLOAT_IS_DOUBLE
//    return number.doubleValue;
//#else
//    return number.floatValue;
//#endif
//}
//
//static char kAssociatedObjectKey_borderInsets;
//- (void)setSwf_borderInsets:(UIEdgeInsets)swf_borderInsets {
//    BOOL valueChanged = !UIEdgeInsetsEqualToEdgeInsets(self.swf_borderInsets, swf_borderInsets);
//    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderInsets, @(swf_borderInsets), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self _swfbd_createBorderLayerIfNeeded];
//    if (valueChanged && self.swf_borderLayer && !self.swf_borderLayer.hidden) {
//        [self setNeedsLayout];
//    }
//}
//
//- (UIEdgeInsets)swf_borderInsets {
//    return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_borderInsets)) UIEdgeInsetsValue];
//}
//
//static char kAssociatedObjectKey_borderColor;
//- (void)setSwf_borderColor:(UIColor *)swf_borderColor {
//    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderColor, swf_borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self _swfbd_createBorderLayerIfNeeded];
//    if (self.swf_borderLayer && !self.swf_borderLayer.hidden) {
//        [self setNeedsLayout];
//    }
//}
//
//- (UIColor *)swf_borderColor {
//    return (UIColor *)objc_getAssociatedObject(self, &kAssociatedObjectKey_borderColor);
//}
//
//static char kAssociatedObjectKey_dashPhase;
//- (void)setSwf_dashPhase:(CGFloat)swf_dashPhase {
//    BOOL valueChanged = self.swf_dashPhase != swf_dashPhase;
//    objc_setAssociatedObject(self, &kAssociatedObjectKey_dashPhase, @(swf_dashPhase), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self _swfbd_createBorderLayerIfNeeded];
//    if (valueChanged && self.swf_borderLayer && !self.swf_borderLayer.hidden) {
//        [self setNeedsLayout];
//    }
//}
//
//- (CGFloat)swf_dashPhase {
//    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_dashPhase);
//#if CGFLOAT_IS_DOUBLE
//    return number.doubleValue;
//#else
//    return number.floatValue;
//#endif
//}
//
//static char kAssociatedObjectKey_dashPattern;
//- (void)setSwf_dashPattern:(NSArray<NSNumber *> *)swf_dashPattern {
//    BOOL valueChanged = [self.swf_dashPattern isEqualToArray:swf_dashPattern];
//    objc_setAssociatedObject(self, &kAssociatedObjectKey_dashPattern, swf_dashPattern, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self _swfbd_createBorderLayerIfNeeded];
//    if (valueChanged && self.swf_borderLayer && !self.swf_borderLayer.hidden) {
//        [self setNeedsLayout];
//    }
//}
//
//- (NSArray *)swf_dashPattern {
//    return (NSArray<NSNumber *> *)objc_getAssociatedObject(self, &kAssociatedObjectKey_dashPattern);
//}
//
//@end
//
//@implementation SWFBorderLayer
//
//- (void)layoutSublayers {
//    [super layoutSublayers];
//    if (!self._swfbd_targetBorderView) return;
//
//    UIView *view = self._swfbd_targetBorderView;
//    CGFloat borderWidth = self.lineWidth;
//    UIEdgeInsets borderInsets = view.swf_borderInsets;
//
//    UIBezierPath *path = [UIBezierPath bezierPath];;
//
//    CGFloat (^adjustsLocation)(CGFloat, CGFloat, CGFloat) = ^CGFloat(CGFloat inside, CGFloat center, CGFloat outside) {
//        return view.swf_borderLocation == SWFViewBorderLocationInside ? inside : (view.swf_borderLocation == SWFViewBorderLocationCenter ? center : outside);
//    };
//
//    CGFloat lineOffset = adjustsLocation(borderWidth / 2.0, 0, -borderWidth / 2.0); // 为了像素对齐而做的偏移
//    CGFloat lineCapOffset = adjustsLocation(0, borderWidth / 2.0, borderWidth); // 两条相邻的边框连接的位置
//    CGFloat verticalInset = borderInsets.top - borderInsets.bottom;
//
//    BOOL shouldShowTopBorder = (view.swf_borderPosition & SWFViewBorderPositionTop) == SWFViewBorderPositionTop;
//    BOOL shouldShowLeftBorder = (view.swf_borderPosition & SWFViewBorderPositionLeft) == SWFViewBorderPositionLeft;
//    BOOL shouldShowBottomBorder = (view.swf_borderPosition & SWFViewBorderPositionBottom) == SWFViewBorderPositionBottom;
//    BOOL shouldShowRightBorder = (view.swf_borderPosition & SWFViewBorderPositionRight) == SWFViewBorderPositionRight;
//
//    NSDictionary<NSString *, NSArray<NSValue *> *> *points = @{
//        @"toppath": @[
//                [NSValue valueWithCGPoint:CGPointMake(
//                                                      (shouldShowLeftBorder ? (-lineCapOffset + verticalInset) : 0) + borderInsets.left,
//                                                      lineOffset + verticalInset
//                                                      )],
//                [NSValue valueWithCGPoint:CGPointMake(
//                                                      CGRectGetWidth(self.bounds) + (shouldShowRightBorder ? (lineCapOffset - verticalInset) : 0) - borderInsets.right,
//                                                      lineOffset + verticalInset
//                                                      )],
//        ],
//        @"leftpath": @[
//                [NSValue valueWithCGPoint:CGPointMake(
//                                                      lineOffset + verticalInset,
//                                                      CGRectGetHeight(self.bounds) + (shouldShowBottomBorder ? lineCapOffset - verticalInset : 0) - borderInsets.left
//                                                      )],
//                [NSValue valueWithCGPoint:CGPointMake(
//                                                      lineOffset + verticalInset,
//                                                      (shouldShowTopBorder ? -lineCapOffset + verticalInset : 0) + borderInsets.right
//                                                      )],
//        ],
//        @"bottompath": @[
//                [NSValue valueWithCGPoint:CGPointMake(
//                                                      CGRectGetWidth(self.bounds) + (shouldShowRightBorder ? (lineCapOffset - verticalInset) : 0) - borderInsets.left,
//                                                      CGRectGetHeight(self.bounds) - lineOffset - verticalInset
//                                                      )],
//                [NSValue valueWithCGPoint:CGPointMake(
//                                                      (shouldShowLeftBorder ? (-lineCapOffset + verticalInset) : 0) + borderInsets.right,
//                                                      CGRectGetHeight(self.bounds) - lineOffset - verticalInset
//                                                      )],
//        ],
//        @"rightpath": @[
//                [NSValue valueWithCGPoint:CGPointMake(
//                                                      CGRectGetWidth(self.bounds) - lineOffset - verticalInset,
//                                                      (shouldShowTopBorder ? -lineCapOffset + verticalInset : 0) + borderInsets.left
//                                                      )],
//                [NSValue valueWithCGPoint:CGPointMake(
//                                                      CGRectGetWidth(self.bounds) - lineOffset - verticalInset,
//                                                      CGRectGetHeight(self.bounds) + (shouldShowBottomBorder ? lineCapOffset - verticalInset : 0) - borderInsets.right
//                                                      )],
//        ],
//    };
//
//    UIBezierPath *topPath = [UIBezierPath bezierPath];
//    UIBezierPath *leftPath = [UIBezierPath bezierPath];
//    UIBezierPath *bottomPath = [UIBezierPath bezierPath];
//    UIBezierPath *rightPath = [UIBezierPath bezierPath];
//
//    if (view.layer.swf_originCornerRadius > 0) {
//
//        CGFloat cornerRadius = view.layer.swf_originCornerRadius;
//        CGFloat radius = cornerRadius - lineOffset;
//
//        if (view.layer.maskedCorners) {
//            if ((view.layer.maskedCorners & kCALayerMinXMinYCorner) == kCALayerMinXMinYCorner) {
//                [topPath addArcWithCenter:CGPointMake(cornerRadius + borderInsets.left + (shouldShowLeftBorder ? verticalInset : 0), cornerRadius + verticalInset) radius:radius startAngle:1.25 * M_PI endAngle:1.5 * M_PI clockwise:YES];
//                [topPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius - borderInsets.right - (shouldShowRightBorder ? verticalInset : 0), lineOffset + verticalInset)];
//                [leftPath addArcWithCenter:CGPointMake(cornerRadius + verticalInset, cornerRadius + borderInsets.right + (shouldShowTopBorder ? verticalInset : 0)) radius:radius startAngle:-0.75 * M_PI endAngle:-1 * M_PI clockwise:NO];
//                [leftPath addLineToPoint:CGPointMake(lineOffset + verticalInset, CGRectGetHeight(self.bounds) - cornerRadius - borderInsets.left - (shouldShowBottomBorder ? verticalInset : 0))];
//            } else {
//                [topPath moveToPoint:points[@"toppath"][0].CGPointValue];
//                [topPath addLineToPoint:CGPointMake(points[@"toppath"][1].CGPointValue.x - cornerRadius, points[@"toppath"][1].CGPointValue.y)];
//                [leftPath moveToPoint:CGPointMake(points[@"leftpath"][0].CGPointValue.x, points[@"leftpath"][0].CGPointValue.y - cornerRadius)];
//                [leftPath addLineToPoint:points[@"leftpath"][1].CGPointValue];
//            }
//            if ((view.layer.maskedCorners & kCALayerMinXMaxYCorner) == kCALayerMinXMaxYCorner) {
//                [leftPath addArcWithCenter:CGPointMake(cornerRadius + verticalInset, CGRectGetHeight(self.bounds) - cornerRadius - borderInsets.left - (shouldShowBottomBorder ? verticalInset : 0)) radius:radius startAngle:-1 * M_PI endAngle:-1.25 * M_PI clockwise:NO];
//                [bottomPath addArcWithCenter:CGPointMake(cornerRadius + borderInsets.right + (shouldShowLeftBorder ? verticalInset : 0), CGRectGetHeight(self.bounds) - cornerRadius - verticalInset) radius:radius startAngle:-1.25 * M_PI endAngle:-1.5 * M_PI clockwise:NO];
//                [bottomPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius - borderInsets.left - (shouldShowRightBorder ? verticalInset : 0), CGRectGetHeight(self.bounds) - lineOffset - verticalInset)];
//            } else {
//                [leftPath moveToPoint:points[@"leftpath"][0].CGPointValue];
//                [leftPath addLineToPoint:CGPointMake(points[@"leftpath"][0].CGPointValue.x, points[@"leftpath"][0].CGPointValue.y - cornerRadius)];
//                [bottomPath moveToPoint:points[@"bottompath"][1].CGPointValue];
//                [bottomPath addLineToPoint:CGPointMake(points[@"bottompath"][0].CGPointValue.x - cornerRadius, points[@"bottompath"][0].CGPointValue.y)];
//            }
//            if ((view.layer.maskedCorners & kCALayerMaxXMaxYCorner) == kCALayerMaxXMaxYCorner) {
//                [bottomPath addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius - borderInsets.left - (shouldShowRightBorder ? verticalInset : 0), CGRectGetHeight(self.bounds) - cornerRadius - verticalInset) radius:radius startAngle:-1.5 * M_PI endAngle:-1.75 * M_PI clockwise:NO];
//                [rightPath addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius - verticalInset, CGRectGetHeight(self.bounds) - cornerRadius - borderInsets.right - (shouldShowBottomBorder ? verticalInset : 0)) radius:radius startAngle:-1.75 * M_PI endAngle:-2 * M_PI clockwise:NO];
//                [rightPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - lineOffset - verticalInset, cornerRadius + borderInsets.left + (shouldShowTopBorder ? verticalInset : 0))];
//            } else {
//                [bottomPath addLineToPoint:points[@"bottompath"][0].CGPointValue];
//                [rightPath moveToPoint:points[@"rightpath"][1].CGPointValue];
//                [rightPath addLineToPoint:CGPointMake(points[@"rightpath"][0].CGPointValue.x, points[@"rightpath"][0].CGPointValue.y + cornerRadius)];
//            }
//            if ((view.layer.maskedCorners & kCALayerMaxXMinYCorner) == kCALayerMaxXMinYCorner) {
//                [rightPath addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius - verticalInset, cornerRadius + borderInsets.left + (shouldShowTopBorder ? verticalInset : 0)) radius:radius startAngle:0 * M_PI endAngle:-0.25 * M_PI clockwise:NO];
//                [topPath addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius - borderInsets.right - (shouldShowRightBorder ? verticalInset : 0), cornerRadius + verticalInset) radius:radius startAngle:1.5 * M_PI endAngle:1.75 * M_PI clockwise:YES];
//            } else {
//                [rightPath addLineToPoint:points[@"rightpath"][0].CGPointValue];
//                [topPath addLineToPoint:points[@"toppath"][1].CGPointValue];
//            }
//        } else {
//            [topPath addArcWithCenter:CGPointMake(cornerRadius, cornerRadius) radius:radius startAngle:1.25 * M_PI endAngle:1.5 * M_PI clockwise:YES];
//            [topPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius, lineOffset)];
//            [topPath addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius, cornerRadius) radius:radius startAngle:1.5 * M_PI endAngle:1.75 * M_PI clockwise:YES];
//
//            [leftPath addArcWithCenter:CGPointMake(cornerRadius, cornerRadius) radius:radius startAngle:-0.75 * M_PI endAngle:-1 * M_PI clockwise:NO];
//            [leftPath addLineToPoint:CGPointMake(lineOffset, CGRectGetHeight(self.bounds) - cornerRadius)];
//            [leftPath addArcWithCenter:CGPointMake(cornerRadius, CGRectGetHeight(self.bounds) - cornerRadius) radius:radius startAngle:-1 * M_PI endAngle:-1.25 * M_PI clockwise:NO];
//
//            [bottomPath addArcWithCenter:CGPointMake(cornerRadius, CGRectGetHeight(self.bounds) - cornerRadius) radius:radius startAngle:-1.25 * M_PI endAngle:-1.5 * M_PI clockwise:NO];
//            [bottomPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius, CGRectGetHeight(self.bounds) - lineOffset)];
//            [bottomPath addArcWithCenter:CGPointMake(CGRectGetHeight(self.bounds) - cornerRadius, CGRectGetHeight(self.bounds) - cornerRadius) radius:radius startAngle:-1.5 * M_PI endAngle:-1.75 * M_PI clockwise:NO];
//
//            [rightPath addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius, CGRectGetHeight(self.bounds) - cornerRadius) radius:radius startAngle:-1.75 * M_PI endAngle:-2 * M_PI clockwise:NO];
//            [rightPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - lineOffset, cornerRadius)];
//            [rightPath addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - cornerRadius, cornerRadius) radius:radius startAngle:0 * M_PI endAngle:-0.25 * M_PI clockwise:NO];
//        }
//
//    } else {
//
//        [topPath moveToPoint:points[@"toppath"][0].CGPointValue];           // 左上角
//        [topPath addLineToPoint:points[@"toppath"][1].CGPointValue];        // 右上角
//
//        [leftPath moveToPoint:points[@"leftpath"][0].CGPointValue];         // 左下角
//        [leftPath addLineToPoint:points[@"leftpath"][1].CGPointValue];      // 左上角
//
//        [bottomPath moveToPoint:points[@"bottompath"][0].CGPointValue];     // 右下角
//        [bottomPath addLineToPoint:points[@"bottompath"][1].CGPointValue];  // 左下角
//
//        [rightPath moveToPoint:points[@"rightpath"][0].CGPointValue];       // 右上角
//        [rightPath addLineToPoint:points[@"rightpath"][1].CGPointValue];    // 右下角
//    }
//
//    if (shouldShowTopBorder && ![topPath isEmpty]) {
//        [path appendPath:topPath];
//    }
//    if (shouldShowLeftBorder && ![leftPath isEmpty]) {
//        [path appendPath:leftPath];
//    }
//    if (shouldShowBottomBorder && ![bottomPath isEmpty]) {
//        [path appendPath:bottomPath];
//    }
//    if (shouldShowRightBorder && ![rightPath isEmpty]) {
//        [path appendPath:rightPath];
//    }
//
//    self.path = path.CGPath;
//}
//
//@end
