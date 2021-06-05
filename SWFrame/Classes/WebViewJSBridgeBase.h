//
//  WebViewJSBridgeBase.h
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/20.
//

#import <Foundation/Foundation.h>

#define kOldProtocolScheme @"wvjsbscheme"
#define kNewProtocolScheme @"https"
#define kQueueHasMessage   @"__wvjsb_queue_message__"
#define kBridgeLoaded      @"__bridge_loaded__"

typedef void (^WVJSBResponseCallback)(id responseData);
typedef void (^WVJSBHandler)(id data, WVJSBResponseCallback responseCallback);
typedef NSDictionary WVJSBMessage;

@protocol WebViewJSBridgeBaseDelegate <NSObject>
- (NSString*) _evaluateJavascript:(NSString*)javascriptCommand;
@end

@interface WebViewJSBridgeBase : NSObject


@property (weak, nonatomic) id <WebViewJSBridgeBaseDelegate> delegate;
@property (strong, nonatomic) NSMutableArray* startupMessageQueue;
@property (strong, nonatomic) NSMutableDictionary* responseCallbacks;
@property (strong, nonatomic) NSMutableDictionary* messageHandlers;
@property (strong, nonatomic) WVJSBHandler messageHandler;

+ (void)enableLogging;
+ (void)setLogMaxLength:(int)length;
- (void)reset;
- (void)sendData:(id)data responseCallback:(WVJSBResponseCallback)responseCallback handlerName:(NSString*)handlerName;
- (void)flushMessageQueue:(NSString *)messageQueueString;
- (void)injectJSFile;
- (BOOL)isWebViewJSBridgeURL:(NSURL*)url;
- (BOOL)isQueueMessageURL:(NSURL*)urll;
- (BOOL)isBridgeLoadedURL:(NSURL*)urll;
- (void)logUnkownMessage:(NSURL*)url;
- (NSString *)webViewJSCheckCommand;
- (NSString *)webViewJSFetchQueyCommand;
- (void)disableJSAlertBoxSafetyTimeout;

@end
