#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Uncompress, NSObject)

RCT_EXTERN_METHOD(
                  extract:(nonnull NSString *)filePath
                  to:(nonnull NSString *)destination
                  overwrite:(BOOL)overwrite
                  password:(NSString *)password
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  )

@end
