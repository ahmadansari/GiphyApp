//
//  Service.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 02/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceError: Error {
    case unknown
}

typealias ServiceResponseHandler<T> = (_ data: T?, _ error: Error?) -> Void

// MARK: - Service Helper
class Service {
    
    final var baseURL: String
    final var servicePath: String
    final var requestMethod: Alamofire.HTTPMethod
    final var encoding: ParameterEncoding
    final var headers: HTTPHeaders?
    final var authentication: Bool?
    final var logRequest: Bool = true

    init(baseURL url: String,
         servicePath path: String,
         requestMethod method: Alamofire.HTTPMethod = .get,
         authentication: Bool = false,
         parameterEncoding encoding: ParameterEncoding = URLEncoding.queryString,
         enableLogging logRequest: Bool = true) {
        self.baseURL = url
        self.servicePath = path
        self.requestMethod = method
        self.encoding = encoding
        self.authentication = authentication
        self.logRequest = logRequest
    }
    
    lazy var translation: Translation = {
        return Translation()
    }()
    
    func addRequestHeader(header:(key: String, value: String)) {
        if self.headers == nil {
            self.headers = HTTPHeaders.init()
        }
        self.headers![header.key] = header.value
    }
    
    func peformRequest(parameters: [String: Any]?, responseHandler:@escaping (DataResponse<Any>?) -> Void) {
        if Connectivity.isConnectedToInternet {
            if let serviceURL = try? self.asURL() {
            
                if self.logRequest == true {
                    print("""
                        Request URL: \(serviceURL),
                        Request Payload:\(parameters ?? [:])
                        Headers:\(self.headers ?? [:])
                        Method: \(self.requestMethod)
                        """)
                }
                
                Alamofire.request(serviceURL,
                                  method: requestMethod,
                                  parameters: parameters,
                                  encoding: encoding,
                                  headers: headers).responseJSON(completionHandler: { (response) in
                                    responseHandler(response)
                                  })
            }
        } else {
            //No Connectivity
            responseHandler(nil)
        }
    }
}

extension Service: URLConvertible {
    func asURL() throws -> URL {
        guard var url = URL(string: self.baseURL) else {
            throw URLError(.badURL)
        }
        url.appendPathComponent(self.servicePath)
        return url
    }
}

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
