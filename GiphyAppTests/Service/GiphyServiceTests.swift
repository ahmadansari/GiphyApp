//
//  GiphyServiceTests.swift
//  GiphyAppTests
//
//  Created by Ahmad Ansari on 04/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//


import XCTest

@testable
import GiphyApp


class GiphyServiceTests: XCTestCase {
    
    var mockService: GiphyMockService!
    
    override func setUp() {
        super.setUp()
        mockService = GiphyMockService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    func testService() {
        XCTAssertNotNil(mockService)
    }
    
    func testServiceResponse() {
        mockService.trendingImages(pageInfo: PageInfo()) { (response, error) in
            XCTAssertNotNil(response)
        }
    }
}

class GiphyMockService: Service, GiphyServiceProtocol {
    
    init() {
        super.init(baseURL: "",
                   servicePath: "")
    }
    
    func trendingImages(pageInfo: PageInfo,
                        completionHandler: @escaping ServiceResponseHandler<GiphyServiceResponse>) {
        
        var giphyResponse: GiphyServiceResponse? = nil
        if let url = Bundle.main.url(forResource: "MockResponse", withExtension: "json") {
            if let mockResponse:String = try? String(contentsOf: url) {
                if let json = try? translation.decode(string: mockResponse) {
                    giphyResponse = try? self.translation.decode(object: json)
                }
            }
        }
        completionHandler(giphyResponse, nil)
    }
}
