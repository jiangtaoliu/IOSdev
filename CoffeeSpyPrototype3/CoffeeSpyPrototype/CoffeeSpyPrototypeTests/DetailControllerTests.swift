//
//  DetailControllerTests.swift
//  CoffeeSpyPrototype
//
//  Created by Roland Askew on 5/25/17.
//  Copyright © 2017 team godzilla. All rights reserved.
//

import XCTest
import CoreLocation
@testable import CoffeeSpyPrototype

class DetailControllerTests: XCTestCase {
    
    var coffeeDetail : CoffeeStoreLocationModel!
    var controllerUnderTest : DetailViewController!
    
    override func setUp() {
        super.setUp()
        controllerUnderTest = DetailViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        coffeeDetail = nil
        controllerUnderTest = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testconfigure()
    {
        coffeeDetail = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testname")
        
        controllerUnderTest.detailItem = coffeeDetail
        controllerUnderTest.configureView()
        
        assert(controllerUnderTest.destination?.coordinate.longitude == coffeeDetail.longitude)
        assert(controllerUnderTest.destination?.coordinate.latitude == coffeeDetail.latitude)
    }
    
}
