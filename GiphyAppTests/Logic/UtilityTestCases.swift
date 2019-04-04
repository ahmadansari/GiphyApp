//
//  UtilityTestCases.swift
//  GiphyAppTests
//
//  Created by Ahmad Ansari on 04/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import XCTest

@testable
import GiphyApp

class UtilityTestCases: XCTestCase {
    
    func testUtility() {
        // given
        let utility = Utility.defaultUtility
        
        // when
        utility.configureSwiftLogger()
        
        // then
        XCTAssertNotNil(SLog.debug(""))
    }
}

