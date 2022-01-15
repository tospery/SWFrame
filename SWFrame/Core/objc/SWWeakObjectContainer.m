//
//  SWWeakObjectContainer.m
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

#import "SWWeakObjectContainer.h"

// from https://github.com/ibireme/YYKit/blob/master/YYKit/Utility/YYWeakProxy.m

@implementation SWWeakObjectContainer

- (instancetype)initWithObject:(id)object {
    _object = object;
    return self;
}

- (instancetype)init {
    return self;
}

+ (instancetype)containerWithObject:(id)object {
    return [[self alloc] initWithObject:object];
}

- (BOOL)isSWFWeakObjectContainer {
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _object;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if (aSelector == @selector(isSWFWeakObjectContainer)) {
        return YES;
    }
    return [_object respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_object isEqual:object];
}

- (NSUInteger)hash {
    return [_object hash];
}

- (Class)superclass {
    return [_object superclass];
}

- (Class)class {
    return [_object class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_object isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_object isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_object conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_object description];
}

- (NSString *)debugDescription {
    return [_object debugDescription];
}

@end

