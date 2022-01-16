//
//  SWHelper.m
//  SWFrame
//
//  Created by liaoya on 2021/4/19.
//

#import "SWHelper.h"
#import "Runtime.h"

@interface SWHelper ()

@end


@implementation SWHelper

static NSMutableSet<NSString *> *executedIdentifiers;
+ (BOOL)executeBlock:(void (NS_NOESCAPE ^)(void))block oncePerIdentifier:(NSString *)identifier {
    if (!block || identifier.length <= 0) return NO;
    @synchronized (self) {
        if (!executedIdentifiers) {
            executedIdentifiers = NSMutableSet.new;
        }
        if (![executedIdentifiers containsObject:identifier]) {
            [executedIdentifiers addObject:identifier];
            block();
            return YES;
        }
        return NO;
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [SWHelper sharedInstance];
    });
}

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

@end

//ExtendImplementationOfNonVoidMethodWithSingleArgument([UIView class], @selector(initWithFrame:), CGRect, UIView *, ^UIView *(UIView *selfObject, CGRect frame, UIView *originReturnValue) {
//    [selfObject _qmuibd_setDefaultStyle];
//    return originReturnValue;
//});
//
//#define ExtendImplementationOfNonVoidMethodWithSingleArgument(_targetClass, _targetSelector, _argumentType, _returnType, _implementationBlock) OverrideImplementation(_targetClass, _targetSelector, ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {\
//        return ^_returnType (__unsafe_unretained __kindof NSObject *selfObject, _argumentType firstArgv) {\
//            \
//            _returnType (*originSelectorIMP)(id, SEL, _argumentType);\
//            originSelectorIMP = (_returnType (*)(id, SEL, _argumentType))originalIMPProvider();\
//            _returnType result = originSelectorIMP(selfObject, originCMD, firstArgv);\
//            \
//            return _implementationBlock(selfObject, firstArgv, result);\
//        };\
//    });
