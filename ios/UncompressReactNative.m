#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(UncompressReactNative, NSObject)

RCT_EXTERN_METHOD(
                  extract:(nonnull NSString *)filePath
                  to:(nonnull NSString *)destination
                  overwrite:(BOOL)overwrite
                  password:(NSString *)password
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  )

RCT_EXTERN_METHOD(
                  isProtected:(nonnull NSString *)filePath
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  )

@end
