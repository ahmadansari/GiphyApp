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

// MARK: - UI Utility Methods
extension Utility {
    func displayErrorAlert(messageText message: String,
                           delegate controller: UIViewController) {
        self.displayAlert(title: "Error",
                          actionTitle: "Cancel",
                          messageText: message,
                          delegate: controller,
                          completionHandler: nil)
    }
    
    func displayErrorAlert(title titleText: String,
                           messageText message: String,
                           delegate controller: UIViewController) {
        let alertController = UIAlertController(title: titleText, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async(execute: { () -> Void in
            controller.present(alertController, animated: true, completion: nil)
            
        })
    }
    
    func displayAlert(title titleText: String,
                      messageText message: String,
                      delegate controller: UIViewController,
                      completionHandler handler:(() -> Void)?) {
        self.displayAlert(title: titleText,
                          actionTitle: "OK",
                          messageText: message,
                          delegate: controller,
                          completionHandler: handler)
    }
    
    func displayAlert(title titleText: String,
                      actionTitle: String,
                      messageText message: String,
                      delegate controller: UIViewController,
                      completionHandler:(() -> Void)? = nil,
                      cancelHandler:(() -> Void)? = nil) {
        let alertController = UIAlertController(title: titleText, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default) { (_) in
            if completionHandler != nil {
                completionHandler!()
            }
        }
        alertController.addAction(okAction)
        
        if let cancelHandler = cancelHandler {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
                cancelHandler()
            }
            alertController.addAction(cancelAction)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            controller.present(alertController, animated: true, completion: nil)
            
        })
    }
}
