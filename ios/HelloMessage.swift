//
//  HelloMessage.swift
//  SampleProject
//
//  Created by Samik Roy on 16/06/25.
//

import Foundation
import React

@objc(HelloMessage)
class HelloMessage: NSObject {
  @objc
  func sayHello(_ name: String, resolver resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) {
    resolve("Hello \(name) from Swift!")
  }

  @objc
  static func requiresMainQueueSetup() -> Bool {
    return false
  }
}
