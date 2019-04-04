//
//  DetailModuleBuilder.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 04/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

class DetailModuleBuilder {
    
    func build(imageDTO: GiphyImageDTO) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        viewController.viewModel = DetailViewModel(with: imageDTO)
        
        return viewController
    }
}
