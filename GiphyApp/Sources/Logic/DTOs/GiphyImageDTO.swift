//
//  GiphyImageDTO.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 02/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

class GiphyImageDTO: NSObject {
    
    private weak var image: GiphyImage?
    
    init(image: GiphyImage) {
        super.init()
        self.image = image
    }
}

extension GiphyImageDTO {
    
    func title() -> String? {
        guard let title = image?.title else {
            return nil
        }
        return title
    }
    
    func previewURL() -> URL? {
        guard let url = image?.previewURL else {
            return nil
        }
        return URL(string: url)
    }
    
    func originalURL() -> URL? {
        guard let url = image?.originalURL else {
            return nil
        }
        return URL(string: url)
    }
}
