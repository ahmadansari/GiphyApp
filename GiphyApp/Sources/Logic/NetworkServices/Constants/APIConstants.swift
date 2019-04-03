//
//  APIConstants.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 02/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

enum API {
    static let baseURL = "https://api.giphy.com"
    static let apiKey = "ZRkOkasd3nX7HLAindo2PK6zQ1YvCRrQ"
}

enum ServicePath {
    static let trending = "/v1/gifs/trending"
}

enum Keys {
    static let apiKey = "api_key"
    static let limit = "limit"
    static let offset = "offset"
}

struct PageInfo {
    var limit: Int = 25
    var offset: Int = 0
}
