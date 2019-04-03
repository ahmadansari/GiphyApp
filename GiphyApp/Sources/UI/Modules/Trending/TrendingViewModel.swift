//
//  TrendingViewModel.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 03/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

typealias VoidBlock = () -> Void

class TrendingViewModel {
    fileprivate var giphyManager = GiphyManager.shared
    fileprivate var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: RXFetchedResultsController!
    
    var pageInfo = PageInfo()
    
    //Navigation Title
    var title = BehaviorSubject<String>(value: "Trending")
    var imagesLoaded = PublishSubject<Void>()
    
    init() {
        configure()
    }
}

extension TrendingViewModel {
    
    // MARK: - Configuration
    func configure() {
        managedObjectContext = CoreDataStack.defaultStack.mainContext
        let titleDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchedResultsController = RXFetchedResultsController(context: managedObjectContext,
                                                              entityName: GiphyImage.entityName,
                                                              sortDescriptors: [titleDescriptor])
    }
    
    func loadViewData() {
        //Fetch 20 pages first
        //pageInfo.limit =  * pageInfo.limit
        fetchTrendingImages(pageInfo: pageInfo) {
            self.fetchedResultsController.performFetch()
            self.imagesLoaded.onNext(())
        }
    }
    
    func loadNextPage() {
        pageInfo.offset += 1
        fetchTrendingImages(pageInfo: pageInfo) {
            self.fetchedResultsController.performFetch()
            self.imagesLoaded.onNext(())
        }
    }
    
    // MARK: - Data Methods
    func fetchTrendingImages(pageInfo: PageInfo, completion: @escaping VoidBlock) {
        giphyManager.fetchTrendingImages(pageInfo)
    }
}
