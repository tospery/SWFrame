#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BZMWebViewJSBridgeBase.h"
#import "BZMWebViewJSBridge_JS.h"
#import "BZMWKWebViewJSBridge.h"

FOUNDATION_EXPORT double BZMWebViewJSBridgeVersionNumber;
FOUNDATION_EXPORT const unsigned char BZMWebViewJSBridgeVersionString[];

