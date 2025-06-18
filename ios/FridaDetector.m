//
//  FridaDetector.m
//  SampleProject
//
//  Created by Samik Roy on 18/06/25.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(FridaDetector, NSObject)
RCT_EXTERN_METHOD(isFridaDetected:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
@end

