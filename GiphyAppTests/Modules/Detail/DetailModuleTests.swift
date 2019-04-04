//
//  DetailModuleTests.swift
//  GiphyAppTests
//
//  Created by Ahmad Ansari on 04/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import XCTest

@testable
import GiphyApp

class DetailModuleTests: XCTestCase {
    
    var builder: DetailModuleBuilder!
    var viewController: DetailViewController!
    
    override func setUp() {
        super.setUp()
        builder = DetailModuleBuilder()
        viewController = builder.build(imageDTO: GiphyImageDTO()) as? DetailViewController
    }
    
    func testViewController() {
        
        let builder = self.builder
        let viewController = self.viewController
        
        // then
        XCTAssertNotNil(builder)
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.viewModel)
    }
    
    func testSetImage() {
        // given
        let viewController = self.viewController
        _ = viewController?.view
        
        // when
        let mockURL = URL(string: "https://media2.giphy.com/media/13Y7TygzhUgT28/giphy-preview.gif")
        viewController?.setImage(mockURL!)
        
        // then
        XCTAssertNotNil(viewController?.imageView.image)
    }
    
    func testLoadViewData() {
        // given
        let viewController = self.viewController
        let viewModel = viewController?.viewModel
        
        // if
        let mockURL = URL(string: "https://media2.giphy.com/media/13Y7TygzhUgT28/giphy-preview.gif")
        let result = viewModel?.loadViewData(imageURL: mockURL)
        
        //then
        XCTAssertTrue(result ?? false)
    }
}

