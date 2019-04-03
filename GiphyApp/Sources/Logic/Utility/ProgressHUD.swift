//
//  ProgressHUD.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 03/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import KRProgressHUD

class ProgressHUD {
    
    class func configureAppearance() {
        //Configure KRProgressHUD Appearance here
        let darkColor = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1)
        let lightColor = UIColor(red: 160.0/255.0, green: 190.0/255.0, blue: 226.0/255.0, alpha: 1)
        KRProgressHUD.appearance().activityIndicatorColors = [UIColor]([darkColor, lightColor])
        KRProgressHUD.appearance().maskType = .black
    }
    
    class func show(viewController: UIViewController) {
        KRProgressHUD.showOn(viewController).show()
    }
    
    class func show(viewController: UIViewController, message: String) {
        KRProgressHUD.showOn(viewController).show(withMessage: message, completion: nil)
    }
    
    class func dismiss() {
        KRProgressHUD.dismiss()
    }
}
