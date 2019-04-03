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
    fileprivate var viewModel = TrendingViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        subscribeForData()
        viewModel.loadViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUI() {
        //Register Custom Cell
        TrendingCollectionCell.register(forCollectionView: collectionView)
    }
    
    func subscribeForData() {
        //Bind Title
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.imagesLoaded.subscribe(onNext: {
            self.reloadData()
        }).disposed(by: disposeBag)
        
        //Subscribe Collection View
        viewModel.fetchedResultsController.subscribe(forCollectionView: collectionView)
        viewModel.fetchedResultsController.performFetch()
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
        let trendingCell: TrendingCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionCell.cellIdentifier, for: indexPath) as! TrendingCollectionCell
        
        if let imageDTO = viewModel.fetchedResultsController.object(at: indexPath) as? GiphyImageDTO {
            trendingCell.configure(imageDTO)
        }
        return trendingCell
    }
}

// MARK: - UICollectionViewDelegate
extension TrendingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //Check If Last Row is about to display, load next page
        if indexPath.row ==  (viewModel.fetchedResultsController.count() - 1) {
            viewModel.loadNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: "imageDetailSegue", sender: indexPath)
    }
}

// MARK: - Navigation
extension TrendingViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageDetailSegue" {
            if segue.destination is DetailViewController {
                let detailViewController = segue.destination as! DetailViewController
                if let imageDTO = viewModel.fetchedResultsController.object(at: sender as! IndexPath) as? GiphyImageDTO {
                    let detailModel = DetailViewModel(with: imageDTO)
                    detailViewController.configure(with: detailModel)
                }
            }
        }
    }
}
