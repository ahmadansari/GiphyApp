//
//  GiphyManager.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 02/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

class GiphyManager {
    
    // MARK: Default Context
    static let shared = GiphyManager()
    
    // Make init private for singleton
    private init() {
        
    }
    
    func fetchTrendingImages(_ pageInfo: PageInfo, _ completionHandler: @escaping (GiphyServiceResponse?, Error?) -> Void) {
        let service = GiphyService()
        completionHandler(nil, nil)
        return
        
        service.trendingImages(pageInfo: pageInfo) { (response, error) in
            if error != nil {
                completionHandler(nil, error)
            } else {
                if let images = response?.imagesList {
                    let context = CoreDataStack.defaultStack.newBackgroundContext()
                    GiphyImage.saveImages(images, context: context, completion: { (error) in
                        completionHandler(response, error)
                    })
                }
            }
        }
    }
}
