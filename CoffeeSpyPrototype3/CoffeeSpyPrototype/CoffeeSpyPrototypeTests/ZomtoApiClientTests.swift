//
//  ZomtoApiClientTests.swift
//  CoffeeSpyPrototype
//
//  Created by Roland Askew on 5/4/17.
//  Copyright © 2017 team godzilla. All rights reserved.
//

import XCTest
@testable import CoffeeSpyPrototype

class ZomtoApiClientTests: XCTestCase {
        
    var testClient : ZomatoApiClient?
    
    class TestingDelegate: ApiClientCallbackDelegate
    {
        public
        var response: [NSDictionary]?
        
        func didFinishApiCall(sender: Any, results : [NSDictionary])
        {
            self.response = results
            
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testClient = ZomatoApiClient( user: "7e6db2d09bc8880b989392b8d2e1e75b" )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        testClient?.stop()
    }
    
    // assert the user key from properties matches the userkey in the testClient object
    func testUserKey() {
        let expectedUserKey = "7e6db2d09bc8880b989392b8d2e1e75b"
        testClient = ZomatoApiClient( user: expectedUserKey )
        
        XCTAssert(expectedUserKey == testClient?.getUserKey())
    }
    
    // set required properties, send a request, and retrieve the data.
    // retrieved data should be a dictionary containing json response.
    func testClientRequestAndRetrieveCoffeeStoreLocations() {
        
        let query = "coffee"
        let count = 3
        let centerLatitude = -36.853439, centerLongitude = 174.760710
        let centerRadius = 1000
        let sort = "cost"
        let order = "asc"
        
        let responseObject = TestingDelegate()
        
        testClient?.setQuery(query: query)
        testClient?.setLatitude(latitude: centerLatitude)
        testClient?.setLongitude(longitude: centerLongitude)
        testClient?.setItemCount(itemCount: count)
        testClient?.setMaxRadius(maxRadius: centerRadius)
        testClient?.setSortItem(sortItem: sort)
        testClient?.setSortOrder(sortOrder: order)
        testClient?.setDelegate(callbackDelegate: responseObject)
        
        testClient?.sendRequest()
        //restaurant = testClient?.getResponse()
        //print(restaurant as Any)
        
        while( !(testClient?.getResponseCompleted())!)
        {
            // wait
        }
        
        print(responseObject.response)
        
        
    }
    
    
}
