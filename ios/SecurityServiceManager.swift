//
//  SecurityServiceManager.swift
//  SampleProject
//
//  Created by Samik Roy on 16/06/25.
//

import Foundation
import React

@objc(SecurityServiceManager)
class SecurityServiceManager: NSObject {

  @objc static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @objc
  func isEmulator(_ resolve: @escaping RCTPromiseResolveBlock,
                  rejecter reject: @escaping RCTPromiseRejectBlock) {
    NSLog("This is a Swift log via NSLog")
    resolve(isRunningOnSimulator())
  }

  @objc
  func isDeviceRooted(_ resolve: @escaping RCTPromiseResolveBlock,
                    rejecter reject: @escaping RCTPromiseRejectBlock) {
    NSLog("This is a Swift log via NSLog isJailBroken")

    if isRunningOnSimulator() {
      resolve(false)
      return
    }

    let paths = ["/Applications/Cydia.app", "/Library/MobileSubstrate/MobileSubstrate.dylib", "/bin/bash", "/usr/sbin/sshd", "/etc/apt"]
    for path in paths {
      if FileManager.default.fileExists(atPath: path) {
        resolve(true)
        return
      }
    }

    if canOpen(path: "/private/jailbreak.txt") {
      resolve(true)
      return
    }

    resolve(false)
  }

  private func isRunningOnSimulator() -> Bool {
    #if targetEnvironment(simulator)
      return true
    #else
      return false
    #endif
  }

  private func canOpen(path: String) -> Bool {
    do {
      try "test".write(toFile: path, atomically: true, encoding: .utf8)
      try FileManager.default.removeItem(atPath: path)
      return true
    } catch {
      return false
    }
  }
  
}

