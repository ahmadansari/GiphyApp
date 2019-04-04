//
//  TrendingCollectionCell.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 03/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class TrendingCollectionCell: UICollectionViewCell {
    
    static let cellIdentifier = "trendingCollectionCell"
    @IBOutlet weak var imageView: UIImageView!
    
    class func register(forCollectionView collectionView: UICollectionView?) {
        guard collectionView != nil else { return }
        collectionView?.register(UINib.init(nibName: "TrendingCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: TrendingCollectionCell.cellIdentifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage.placeholderImage
    }
    
    func configure(_ imageDTO: GiphyImageDTO) {
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: imageDTO.previewURL(),
                                  placeholder: UIImage.placeholderImage)
        }
    }
}
