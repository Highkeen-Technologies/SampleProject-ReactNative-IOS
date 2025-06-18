//
//  SSLPinning.m
//  SampleProject
//
//  Created by Samik Roy on 18/06/25.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SSLPinning, NSObject)



RCT_EXTERN_METHOD(validateCertificate:(NSString *)apiUrl
                  localCertAssetName:(NSString *)localCertAssetName
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
    
@end
