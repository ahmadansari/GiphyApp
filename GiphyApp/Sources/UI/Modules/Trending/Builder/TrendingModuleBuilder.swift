//
//  TrendingBuilder.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 04/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

class TrendingModuleBuilder {
    
    func build() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TrendingViewController") as! TrendingViewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let viewModel = TrendingViewModel()
        viewModel.moduleCoordinator = TrendingModuleCoordinator(navigationController: navigationController)
            
        viewController.viewModel = viewModel
        
        return navigationController
    }
}
