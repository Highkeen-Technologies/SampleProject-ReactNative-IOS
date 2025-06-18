//
//  FridaDetector.swift
//  SampleProject
//
//  Created by Samik Roy on 18/06/25.
//


import Foundation
import React

@objc(FridaDetector)
class FridaDetector: NSObject {

  @objc
  func isFridaDetected(_ resolve: @escaping RCTPromiseResolveBlock,
                       rejecter reject: @escaping RCTPromiseRejectBlock) {
    let imageCount = _dyld_image_count()
    for i in 0..<imageCount {
      if let name = _dyld_get_image_name(i) {
        let imagePath = String(cString: name).lowercased()
        if imagePath.contains("frida") || imagePath.contains("gadget") {
          resolve(true)
          return
        }
      }
    }

    let suspiciousPaths = ["/usr/sbin/frida-server", "/usr/bin/frida-server"]
    for path in suspiciousPaths {
      if FileManager.default.fileExists(atPath: path) {
        resolve(true)
        return
      }
    }

    resolve(false)
  }

  @objc static func requiresMainQueueSetup() -> Bool {
    return false
  }
}

