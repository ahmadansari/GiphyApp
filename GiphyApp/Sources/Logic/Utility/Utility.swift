//
//  Utility.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 02/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit
import SwiftyBeaver

//Swift Logger
let SLog = SwiftyBeaver.self

class Utility: NSObject {
    
    // Make init private for singleton
    private override init() {
    }
    
    // MARK: Default Context
    static let defaultUtility = Utility()
    
    func configureSwiftLogger() {
        // add console log destinations
        let console = ConsoleDestination()  // log to Xcode Console
        
        // log format : console output to short time, log level & message
        console.format = Constants.loggerFormat
        
        // add the destinations to SwiftyBeaver
        SLog.addDestination(console)
    }
}
