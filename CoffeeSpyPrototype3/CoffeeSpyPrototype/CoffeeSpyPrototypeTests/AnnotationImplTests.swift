//
//  AnnotationImplTests.swift
//  CoffeeSpyPrototype
//
//  Created by Roland Askew on 6/3/17.
//  Copyright © 2017 team godzilla. All rights reserved.
//

import XCTest
import CoreLocation
@testable import CoffeeSpyPrototype



class AnnotationImplTests: XCTestCase {
    
    var annotation: AnnotationImpl?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAnnotationImpl() {
        let title = "mytitle"
        let subtitle = "mysubtitle"
        let location = CLLocation(latitude: 0, longitude: 0)
        annotation = AnnotationImpl(title: title, subtitle: subtitle, coordinate: location.coordinate)
        
        assert(annotation?.title == title)
        assert(annotation?.subtitle == subtitle)
        assert(annotation?.coordinate.latitude == location.coordinate.latitude)
        assert(annotation?.coordinate.longitude == location.coordinate.longitude)
    }
}
