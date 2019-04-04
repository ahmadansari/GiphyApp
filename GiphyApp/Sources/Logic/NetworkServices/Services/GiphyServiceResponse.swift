//
//  GiphyServiceResponse.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 03/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

struct GiphyServiceResponse: Codable {
    let imagesList: [ImageData]
    let pagination: Pagination
    
    private enum CodingKeys: String, CodingKey {
        case imagesList = "data"
        case pagination
    }
}

struct Pagination: Codable {
    let count: Int
    let offset: Int
    let totalCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case count
        case offset
        case totalCount = "total_count"
    }
}

struct ImageData: Codable {
    let id: String
    let title: String?
    let images: Images
    let trendingDatetime: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case images
        case trendingDatetime = "trending_datetime"
    }
}

struct Images: Codable {
    let original: OriginalImage
    let preview: PreviewImage
    let downsized: DownsizedImage
    
    private enum CodingKeys: String, CodingKey {
        case original
        case preview = "preview_gif"
        case downsized
    }
}

struct OriginalImage: Codable {
    let url: String?
}

struct PreviewImage: Codable {
    let url: String?
}

struct DownsizedImage: Codable {
    let url: String?
}
