//
//  UIColor+Extension.swift
//  
//
//  Created by Ahmad Ansari on 10/4/18.
//  Copyright © 2018 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: Float = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    
    convenience init(hexValue: Int, alpha: Float = 1.0) {
        self.init(red: (hexValue >> 16) & 0xff, green: (hexValue >> 8) & 0xff, blue: hexValue & 0xff, alpha: alpha)
    }
}
