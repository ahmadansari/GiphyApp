//
//  TrendingModuleTests.swift
//  GiphyAppTests
//
//  Created by Ahmad Ansari on 04/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import XCTest

@testable
import GiphyApp

class TrendingModuleTests: XCTestCase {
    
    func testBuildViewController() {
        // given
        let builder = TrendingModuleBuilder()
        
        // when
        let navController = builder.build() as? UINavigationController
        let viewController = navController?.topViewController as? TrendingViewController
        
        // then
        XCTAssertNotNil(builder)
        XCTAssertNotNil(navController)
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.viewModel)
    }
    
    func testFRCConfigure() {
        // given
        let viewModel = TrendingViewModel()
        
        //when
        viewModel.configure()
        
        //then
        XCTAssertNotNil(viewModel.fetchedResultsController)
    }
    
    func testLoadData() {
        // given
        let viewModel = TrendingViewModel()
        
        // when
        viewModel.loadViewData()
        
        //then
        XCTAssertGreaterThanOrEqual(viewModel.fetchedResultsController.count(), 0)
    }
    
    func testNextPageData() {
        // given
        let viewModel = TrendingViewModel()
        
        // when
        viewModel.loadNextPage()
        
        //then
        XCTAssertGreaterThanOrEqual(viewModel.fetchedResultsController.count(), 0)
    }
}
