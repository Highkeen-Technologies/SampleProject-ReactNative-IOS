//
//  CertificateValidator.swift
//  SampleProject
//
//  Created by Samik Roy on 18/06/25.
//

import Foundation

class CertificateValidator: NSObject, URLSessionDelegate {
    let localCertName: String
    let onSuccess: () -> Void
    let onFailure: (String) -> Void

    init(localCertName: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        self.localCertName = localCertName
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }

  /*func urlSession(_ session: URLSession,
                  didReceive challenge: URLAuthenticationChallenge,
                  completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

      guard let serverTrust = challenge.protectionSpace.serverTrust else {
          onFailure("No server trust available")
          completionHandler(.cancelAuthenticationChallenge, nil)
          return
      }

      // Apply SSL policy
      let policy = SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString)
      SecTrustSetPolicies(serverTrust, policy)

      // Evaluate trust
      var error: CFError?
      let isServerTrusted = SecTrustEvaluateWithError(serverTrust, &error)

      // Get server certificate
      guard let certChain = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate],
            let serverCert = certChain.first else {
          onFailure("Unable to extract server certificate")
          completionHandler(.cancelAuthenticationChallenge, nil)
          return
      }

      let serverCertData = SecCertificateCopyData(serverCert) as Data

      // Split using last "."
      guard let dotIndex = localCertName.lastIndex(of: ".") else {
          onFailure("Invalid certificate filename (missing extension)")
          completionHandler(.cancelAuthenticationChallenge, nil)
          return
      }

      let resourceName = String(localCertName[..<dotIndex])
      let resourceExt = String(localCertName[localCertName.index(after: dotIndex)...])

      // Load local certificate
      guard let localCertPath = Bundle.main.path(forResource: resourceName, ofType: resourceExt),
            let localCertData = try? Data(contentsOf: URL(fileURLWithPath: localCertPath)) else {
          onFailure("Local certificate '\(localCertName)' not found in bundle")
          completionHandler(.cancelAuthenticationChallenge, nil)
          return
      }

      // Compare certificates
      if isServerTrusted && serverCertData == localCertData {
          let credential = URLCredential(trust: serverTrust)
          onSuccess()
          completionHandler(.useCredential, credential)
      } else {
          onFailure("Certificate mismatch or untrusted server")
          completionHandler(.cancelAuthenticationChallenge, nil)
      }
  }*/
  
  func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
          guard let serverTrust = challenge.protectionSpace.serverTrust else {
              completionHandler(.cancelAuthenticationChallenge, nil);
              return
          }
    
          // Get server certificate
          guard let certChain = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate],
                let serverCert = certChain.first else {
              onFailure("Unable to extract server certificate")
              completionHandler(.cancelAuthenticationChallenge, nil)
              return
          }

         // let serverCertData = SecCertificateCopyData(serverCert) as Data
          
      //let certificate = SecCertificateCopyData(serverCert) as Data
          
          // SSL Policies for domain name check
          let policy = NSMutableArray()
          policy.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))
          
          //evaluate server certifiacte
          let isServerTrusted = SecTrustEvaluateWithError(serverTrust, nil)
          
          //Local and Remote certificate Data
          let remoteCertificateData:NSData =  SecCertificateCopyData(serverCert)
    
          // Split using last "."
          guard let dotIndex = localCertName.lastIndex(of: ".") else {
              onFailure("Invalid certificate filename (missing extension)")
              completionHandler(.cancelAuthenticationChallenge, nil)
              return
          }

          let resourceName = String(localCertName[..<dotIndex])
          let resourceExt = String(localCertName[localCertName.index(after: dotIndex)...])
          
          guard let pathToCertificate = Bundle.main.path(forResource: resourceName, ofType: resourceExt),
                let localCertData = try? Data(contentsOf: URL(fileURLWithPath: pathToCertificate)) else {
              onFailure("❌ Local certificate '\(localCertName)' not found or unreadable")
              completionHandler(.cancelAuthenticationChallenge, nil)
              return
          }
          let localCertificateData:NSData = NSData(contentsOfFile: pathToCertificate)!
    
    
    
          print("🔐 isServerTrusted for: \(isServerTrusted)")
          print("🔐 remoteCertificateData for: \(remoteCertificateData)")
          print("🔐 localCertificateData for: \(localCertificateData)")
          //Compare certificates
          if(isServerTrusted && remoteCertificateData.isEqual(to: localCertificateData as Data)){
            let _:URLCredential =  URLCredential(trust:serverTrust)
              print("Certificate pinning is successfully completed")
              onSuccess()
              completionHandler(.useCredential,nil)
          }
          else {
              onFailure("Certificate mismatch or untrusted server")
              completionHandler(.cancelAuthenticationChallenge,nil)
          }
      }


}

