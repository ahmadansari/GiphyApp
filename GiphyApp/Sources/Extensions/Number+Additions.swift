//
//  Number+Additions.swift
//
//
//  Created by Ahmad Ansari on 7/25/18.
//  Copyright © 2018 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

extension Int64 {
    static var randomValue: Int64 {
        return Int64(arc4random()) + (Int64(arc4random()) << 32)
    }
    
    func converToStringLocalized() -> String? {
        let formatter = NumberFormatter()
        //        let language = Utility.defaultUtility.currentLanguage()
        //        formatter.locale = Locale(identifier: language.localeTag())
        return formatter.string(from: NSNumber(value: self))
    }

}

extension Double {
    var isInteger: Bool {
        return rint(self) == self
    }
    
    var degreesToRadians: Double {
        return (Double.pi / 180) * self
    }
    
    var radiansToDegrees: Double {
        return (180 / Double.pi) * self
    }
    
    var zeroDecimalToWhole: (wholeNumber: Int64, isWhole: Bool) {
        guard let decimalPart = "\(self)".components(separatedBy: ".").last, Int64(decimalPart) ?? 0 > 0 else {
            return (Int64(self), true)
        }
        return (Int64(self), false)
    }
    
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let divisor = pow(10.0, Double(fractionDigits))
        return (self * divisor).rounded() / divisor
    }
    
    func convertFromKGToPounds() -> Double {
        return Measurement(value: self, unit: UnitMass.kilograms).converted(to: .pounds).value
    }
    
    func convertFromPoundsToKG() -> Double {
        return Measurement(value: self, unit: UnitMass.pounds).converted(to: .kilograms).value
    }
    
    func convertFromMgdlToMmoL() -> Double {
        return self/18
    }
    
    func convertFromMmolToMgdl () -> Double {
        return self * 18
    }
}

extension Double {
    func converToStringLocalized() -> String? {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.roundingMode = .halfUp
        formatter.numberStyle = .decimal
//        let language = Utility.defaultUtility.currentLanguage()
//        formatter.locale = Locale(identifier: language.localeTag())
        return formatter.string(from: NSNumber(value: self))
    }
}

extension Int {
    func converToStringLocalized() -> String? {
        let formatter = NumberFormatter()
//        let language = Utility.defaultUtility.currentLanguage()
//        formatter.locale = Locale(identifier: language.localeTag())
        return formatter.string(from: NSNumber(value: self))
    }
}
