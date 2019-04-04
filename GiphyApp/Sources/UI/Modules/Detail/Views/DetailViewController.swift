//
//  DetailViewController.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 03/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    fileprivate let disposeBag = DisposeBag()
    
    //Image Presenter
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadViewData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ProgressHUD.dismiss()
    }
}

extension DetailViewController {
    
    // MARK: - Data Population
    func configure(with viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    func subscribeForData() {
        
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.showProgress.subscribe(onNext: {
            ProgressHUD.show(viewController: self)
        }).disposed(by: disposeBag)
        
        Observable.of(viewModel.imageLoaded)
            .observeOn(MainScheduler())
            .subscribeOn(MainScheduler())
            .subscribe { (_) in
                if let url = self.viewModel.imageDTO.downsizedURL() {
                    self.setImage(url)
                }
            }.disposed(by: disposeBag)
    }
    
    func setImage(_ url: URL) {
        self.imageView.kf.setImage(with: url,
                                   placeholder: UIImage.placeholderImage,
                                   completionHandler: { _ in
            ProgressHUD.dismiss()
        })
    }
}
