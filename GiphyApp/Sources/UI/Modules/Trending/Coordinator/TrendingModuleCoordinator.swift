//
//  TrendingModuleCoordinator.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 04/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

class TrendingModuleCoordinator {
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

extension TrendingModuleCoordinator {
    
    func showDetailPage(imageDTO: GiphyImageDTO) {
        let detailController = DetailModuleBuilder().build(imageDTO: imageDTO)
        navigationController?.pushViewController(detailController, animated: true)
    }
}
