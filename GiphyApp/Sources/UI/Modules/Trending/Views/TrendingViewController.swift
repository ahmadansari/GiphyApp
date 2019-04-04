//
//  TrendingViewController.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 02/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: TrendingViewModel!
    fileprivate let disposeBag = DisposeBag()
    fileprivate var pageLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        subscribeForData()
        
        pageLoading = true
        viewModel.loadViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUI() {
        //Navigaiton
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onTapLoadMore))
        
        //Register Custom Cell
        TrendingCollectionCell.register(forCollectionView: collectionView)
    }
    
    @objc func onTapLoadMore() {
        viewModel.loadNextPage()
    }
    
    func subscribeForData() {
        //Bind Title
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.imagesLoaded
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.reloadData()
                self?.pageLoading = false
                ProgressHUD.dismiss()
            }).disposed(by: disposeBag)
        
        viewModel.showProgress
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: {
                ProgressHUD.show(viewController: self)
            }).disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .asDriver()
            .drive(onNext: { [weak self] (indexPath) in
                self?.viewModel.didSelectItem.onNext(indexPath)
            }).disposed(by: disposeBag)
        
        //Subscribe Collection View
        viewModel.fetchedResultsController.subscribe(forCollectionView: collectionView)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TrendingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 20.0
        let width = (collectionView.bounds.width - spacing)/3.0
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
}

// MARK: - UICollectionViewDataSource
extension TrendingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.fetchedResultsController.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Image Cell
        let trendingCell: TrendingCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionCell.cellIdentifier, for: indexPath) as! TrendingCollectionCell
        
        if let imageDTO = viewModel.fetchedResultsController.object(at: indexPath) as? GiphyImageDTO {
            trendingCell.configure(imageDTO)
        }
        return trendingCell
    }
}

// MARK: - UICollectionViewDelegate
extension TrendingViewController: UICollectionViewDelegate {
    
    //Uncomment Following code for auto paging
    /*
    //Paging
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //Check If Last Row is about to display, load next page
        if isLastCell(indexPath: indexPath) && !pageLoading {
            viewModel.loadNextPage()
        }
    }
    
    func isLastCell(indexPath: IndexPath) -> Bool {
        if indexPath.row >= (viewModel.fetchedResultsController.count() - 1) {
            return true
        }
        return false
    }
     */
    
}

// MARK: - Orientation
extension TrendingViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)        
        coordinator.animate(alongsideTransition: { (_) in
            self.reloadData()
        }, completion: nil)
    }
}
