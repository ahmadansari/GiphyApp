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
import RxCocoa

typealias VoidBlock = () -> Void

class TrendingViewModel {
    fileprivate var giphyManager = GiphyManager.shared
    fileprivate var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: RXFetchedResultsController!
    var moduleCoordinator: TrendingModuleCoordinator!
    fileprivate let disposeBag = DisposeBag()
    
    var pageInfo = PageInfo()
    var pagination: Pagination?
    
    //Model Output
    var title = BehaviorSubject<String>(value: "Trending")
    var imagesLoaded = PublishSubject<Void>()
    var showProgress = PublishSubject<Void>()
    
    //Model Input
    var didSelectItem = BehaviorSubject<IndexPath?>(value: nil)
    
    init() {
        configure()
        
        //Subscribe Model Input
        didSelectItem.subscribe(onNext: { [weak self] (indexPath) in
            guard indexPath != nil else {
                return
            }
            self?.didSelectItem(atIndexPath: indexPath!)
        }).disposed(by: disposeBag)
    }
}

extension TrendingViewModel {
    
    // MARK: - Configuration
    func configure() {
        managedObjectContext = CoreDataStack.defaultStack.mainContext
        let dateDescriptor = NSSortDescriptor(key: "cachedDate", ascending: true)
        fetchedResultsController = RXFetchedResultsController(context: managedObjectContext,
                                                              entityName: GiphyImage.entityName,
                                                              sortDescriptors: [dateDescriptor])
        self.fetchedResultsController.removeDelegate()
        self.fetchedResultsController.performFetch(completion: { (_) in
        })
    }
    
    func loadViewData() {
        //Fetch 20 pages first in one go
        let pages = 20
        pageInfo.offset = 0
        pageInfo.limit =  pages * pageInfo.limit
        showProgress.onNext(())
        giphyManager.fetchTrendingImages(pageInfo) { (response, error) in
            if error != nil {
                print("Error: \(String(describing: error))")
            } else {
                if let pagination = response?.pagination {
                    //Resetting Page limit to default page size: 25
                    self.pageInfo.limit = pagination.count/pages
                    self.pageInfo.offset += pagination.count
                }
            }
            self.fetchedResultsController.performFetch(completion: { (_) in
                self.imagesLoaded.onNext(())
            })
        }
    }
    
    func loadNextPage() {
        giphyManager.fetchTrendingImages(pageInfo) { (response, error) in
            if error != nil {
                print("Error: \(String(describing: error))")
            } else {
                if let pagination = response?.pagination {
                    self.pageInfo.offset += pagination.count
                }
            }
            self.fetchedResultsController.performFetch(completion: { (_) in
                self.imagesLoaded.onNext(())
            })
        }
    }
}

//Navigation
extension TrendingViewModel {
    func didSelectItem(atIndexPath indexPath: IndexPath) {
        if let imageDTO = fetchedResultsController.object(at: indexPath) as? GiphyImageDTO {
            moduleCoordinator.showDetailPage(imageDTO: imageDTO)
        }
    }
}
