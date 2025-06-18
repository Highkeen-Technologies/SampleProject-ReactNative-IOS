//
//  SSLPinning.swift
//  SampleProject
//
//  Created by Samik Roy on 18/06/25.
//

import Foundation
import React

@objc(SSLPinning)
class SSLPinning: NSObject {
  
 
  @objc
  func validateCertificate(_ apiUrl: String,localCertAssetName: String,resolver resolve: @escaping RCTPromiseResolveBlock,
                           rejecter reject: @escaping RCTPromiseRejectBlock) {
       print("🔐 Starting certificate validation for: \(apiUrl)")
       NSLog("🔐 Local cert file: %@", localCertAssetName)
        guard let url = URL(string: apiUrl) else {
              reject("INVALID_URL", "URL is invalid", nil)
              return
            }

        let session = URLSession(configuration: .ephemeral,
                                 delegate: CertificateValidator(localCertName: localCertAssetName,
                                                                onSuccess: {
                                                                  resolve(true)
                                                                },
                                                                onFailure: { errorMessage in
                                                                  reject("CERT_INVALID", errorMessage, nil)
                                                                }),
                                 delegateQueue: nil)

        let task = session.dataTask(with: url)
        task.resume()
    
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return false
  }
}
