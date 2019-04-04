//
//  DetailViewModel.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 03/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import Kingfisher
import RxSwift

class DetailViewModel {
    var imageDTO: GiphyImageDTO!
    
    //Navigation Title
    var title = BehaviorSubject<String>(value: "")
    
    // MARK: Publish Event
    var imageLoaded = PublishSubject<URL?>()
    var showProgress = PublishSubject<Void>()
}

// MARK: - Data Methods
extension DetailViewModel {
    convenience init(with imageDTO: GiphyImageDTO) {
        self.init()
        self.imageDTO = imageDTO
    }
    
    func loadViewData() {
        loadViewData(imageURL: imageDTO.downsizedURL())
    }
    
    @discardableResult
    func loadViewData(imageURL: URL?) -> Bool {
        if let url = imageURL {
            
            if let imageTitle: String = imageDTO.title() {
                self.title.onNext(imageTitle)
            }
            
            if !ImageCache.default.isCached(forKey: url.absoluteString) {
                showProgress.onNext(())
            }
            
            KingfisherManager.shared.retrieveImage(with: url) { [weak self] _ in
                self?.imageLoaded.onNext((url))
            }
            return true
        }
        return false
    }
}
