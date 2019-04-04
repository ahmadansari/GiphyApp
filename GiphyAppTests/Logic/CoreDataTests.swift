//
//  CoreDataTests.swift
//  GiphyAppTests
//
//  Created by Ahmad Ansari on 04/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import XCTest
@testable
import GiphyApp

class CoreDataTests: XCTestCase {
    
    var mockService: GiphyMockService!
    var coreDataStack:CoreDataStack!
    
    override func setUp() {
        super.setUp()
        mockService = GiphyMockService()
        coreDataStack = CoreDataStack.defaultStack
    }
    
    override func tearDown() {
        mockService = nil
        coreDataStack = nil
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertNotNil(mockService)
    }
    
    
    func testResponsePersistence() {
        
        let context = coreDataStack.newBackgroundContext()
        XCTAssertNotNil(context)
        
        mockService.trendingImages(pageInfo: PageInfo()) { (response, error) in
            XCTAssertNotNil(response)
            XCTAssertNotNil(response?.imagesList)
            
            if let imagesList = response?.imagesList {
                GiphyImage.saveImages(imagesList,
                                      context: context,
                                      completion: { (error) in
                                        XCTAssertNil(error)
                })
            }
        }
    }
}
