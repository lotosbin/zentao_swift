//
//  File.swift
//  
//
//  Created by 刘斌斌 on 2022/11/2.
//

import Foundation
import Logging

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class ZentaoRequest {
    private let logger = Logger(label:"ZentaoRequest")
    func get(path: String) async -> String {
        var request = URLRequest(url: URL(string: path)!, timeoutInterval: Double.infinity)
        request.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36", forHTTPHeaderField: "User-Agent")
        request.httpMethod = "GET"
        
        //        if (let cookies = HTTPCookieStorage.shared.cookies(for: URL.init(string: path)!))  {
        //            request.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: cookies)
        //        }
        //
        let (data, response) = try! await URLSession.shared.data(for: request)
        
        let s = String(data: data, encoding: .utf8)!
        return s
    }
    
    //        let parameters: [String: Any]  = ["mobile" : mobileNumber] as Dictionary<String, Any>
    
    func post(path:String,json parameters:[String: Any]) async -> String {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        logger.info("post url:\(request.url),body:\(request.httpBody)")
        let (data, response) = try! await session.data(for: request)
        let s = String(data: data, encoding: .utf8)!
        return s
    }
    func post(path:String,body parameters:[String: Any]) async -> String {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEncoded()
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        logger.info("post url:\(request.url),body:\(request.httpBody)")
        let (data, response) = try! await session.data(for: request)
        let s = String(data: data, encoding: .utf8)!
        return s
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
