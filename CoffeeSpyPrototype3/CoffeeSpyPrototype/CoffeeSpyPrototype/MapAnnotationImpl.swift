//
//  mapAnnotation.swift
//  CoffeeSpyPrototype
//
//  Created by Xinyu Qu on 5/9/17.
//  Copyright © 2017 team godzilla. All rights reserved.
//

import MapKit

class AnnotationImpl: NSObject, MKAnnotation {
    public var title : String?
    public var subtitle: String?
    public var coordinate : CLLocationCoordinate2D
    
    init(title : String, subtitle: String, coordinate : CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
