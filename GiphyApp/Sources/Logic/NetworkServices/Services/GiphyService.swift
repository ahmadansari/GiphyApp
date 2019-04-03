//
//  GiphyService.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 02/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

// MARK: - Giphy Service
final class GiphyService: Service {
    init() {
        super.init(baseURL: API.baseURL,
                   servicePath: ServicePath.trending)
    }
    
    func trendingImages(pageInfo: PageInfo,
                        completionHandler: @escaping ServiceResponseHandler<GiphyServiceResponse>) {
        
        let parameters: [String: Any] = [Keys.limit: pageInfo.limit,
                                         Keys.offset: pageInfo.offset,
                                         Keys.apiKey: API.apiKey
        ]
        
        self.peformRequest(parameters: parameters) { (response) in
            if (response == nil || response?.error != nil) {
                let error = response?.error
                SLog.error(error as Any)
                completionHandler(nil, error)
            } else {
                if let json: Any = response?.value {
                    do {
                        let giphyResponse: GiphyServiceResponse = try self.translation.decode(object: json)     
                        completionHandler(giphyResponse, nil)
                    } catch {
                        completionHandler(nil, error)
                    }
                } else {
                    completionHandler(nil, ServiceError.unknown)
                }
            }
        }
    }
}
