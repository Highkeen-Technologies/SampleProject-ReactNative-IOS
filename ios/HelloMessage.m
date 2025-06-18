//
//  HelloMessage.m
//  SampleProject
//
//  Created by Samik Roy on 16/06/25.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(HelloMessage, NSObject)

RCT_EXTERN_METHOD(sayHello:(NSString *)name
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
