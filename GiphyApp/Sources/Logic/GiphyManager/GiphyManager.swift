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
    
    func fetchTrendingImages(_ pageInfo: PageInfo) {
        let service = GiphyService()
        service.trendingImages(pageInfo: pageInfo) { (response, error) in
            if error != nil {
                print(error)
            } else {
                if let images = response?.imagesList {
                    GiphyImage.saveImages(images,
                                          context: CoreDataStack.defaultStack.newBackgroundContext())
                }
            }
        }
    }
}
