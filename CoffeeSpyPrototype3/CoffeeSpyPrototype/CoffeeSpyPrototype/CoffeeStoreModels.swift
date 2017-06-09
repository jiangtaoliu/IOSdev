//
//  CoffeeStoreModel.swift
//  prototype_master_detail
//
//  Created by Roland Askew on 4/11/17.
//  Copyright © 2017 unitec. All rights reserved.
//

import Foundation
import CoreLocation

class CoffeeStoreLocationModel {
    
    private
    var lat: Double?

    public
    var latitude: Double  {
        get {
            return self.lat!
        }
    }
    
    private
    var long: Double?
    
    public
    var longitude: Double {
        get {
            return self.long!
        }
    }
    
    
    private
    var dist: Double?
    
    public
    var distance: Double {
        get {
            return self.dist!
        }
    }
    
    private
    var name: String?
    
    private
    var address: String?
    
    private
    var averagePriceforTwoInCents: Int?
    
    public
    var averagePriceForTwo : Double {
        get {
            return Double(averagePriceforTwoInCents!) / 100.0
        }
    }
    
    init(latitude : Double, longitude : Double, placeName : String) {
        self.lat = latitude
        self.long = longitude
        self.name = placeName
        self.address = "?"
        self.dist = 0.0
        self.averagePriceforTwoInCents = 0
        self.checkLatitude()
        self.checkLongitude()
    }
    
    convenience init(latitude : Double, longitude : Double, placeName : String, placeAddress: String) {
        self.init(latitude: latitude, longitude: longitude, placeName: placeName)
        address = placeAddress
    }
    
    convenience init(latitude : Double, longitude : Double, placeName : String, placeAddress: String, averagePriceInCents : Int) {
        self.init(latitude: latitude, longitude: longitude, placeName: placeName, placeAddress: placeAddress)
        averagePriceforTwoInCents = averagePriceInCents
        checkAveragePrice()
    }
    
    convenience init(latitude : Double, longitude : Double, placeName : String, placeAddress: String, averagePrice : Double) {
        self.init(latitude: latitude, longitude: longitude, placeName: placeName, placeAddress: placeAddress)
        averagePriceforTwoInCents = Int(averagePrice * 100.0)
        checkAveragePrice()
    }
    
    private
    func checkAveragePrice()
    {
        if averagePriceforTwoInCents! < 0 {
            averagePriceforTwoInCents = 0
        }
    }
    
    private
    func checkLatitude()
    {
        if self.lat! > 90.0
        {
            self.lat = 90.0
        }
        else if self.lat! < -90.0
        {
            self.lat = -90.0
        }
    }
    
    private
    func checkLongitude()
    {
        if self.long! < -180.0
        {
            self.long = -180.0
        }
        else if self.long! > 180.0
        {
            self.long = 180.0
        }
    }
    
    func getLatitude() -> Double
    {
        return self.lat!
    }
    
    func getLongitude() -> Double
    {
        return self.long!
    }
    
    func getName() -> String
    {
        return name!
    }
    
    func setName( newName : String)
    {
        name = newName
    }
    
    func getAddress() -> String
    {
        return address!
    }
    
    func setAddress( newAddress : String)
    {
        address = newAddress
    }
    
    func getAveragePriceForTwo() -> Double
    {
        return Double(averagePriceforTwoInCents!) / 100.0
    }
    
    func setAveragePriceForTwo( newPriceInCents : Int)
    {
        averagePriceforTwoInCents = newPriceInCents
        checkAveragePrice()
    }
    
    func setAveragePriceForTwo( newPrice : Double)
    {
        averagePriceforTwoInCents = Int(newPrice * 100.0)
        checkAveragePrice()
    }
    
    func getDistance() -> Double
    {
        return dist!
    }
    
    func setDistance( location: CLLocation)
    {
        let here = CLLocation(latitude: self.latitude, longitude: self.longitude)
        dist = location.distance(from: here)
    }

}
