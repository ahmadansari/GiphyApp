//
//  UIView+Extensions.swift
//  
//
//  Created by Ahmad Ansari on 7/29/18.
//  Copyright © 2018 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Instacne Methods
extension UIView {
    
    func addSubview(_ subview: UIView, addConstraints: Bool) {
        let superview = self
        superview.addSubview(subview)
        if addConstraints {
            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            subview.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            subview.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}
