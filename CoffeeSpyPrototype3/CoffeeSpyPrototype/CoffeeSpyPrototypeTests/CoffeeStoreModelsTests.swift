//
//  CoffeeStoreModelsTests.swift
//  CoffeeSpyPrototype
//
//  Created by Roland Askew on 4/11/17.
//  Copyright © 2017 team godzilla. All rights reserved.
//

import XCTest
import CoreLocation
@testable import CoffeeSpyPrototype

class CoffeeStoreModelsTests: XCTestCase {
    
    var coffeeLocation : CoffeeStoreLocationModel!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        coffeeLocation = nil
    }
    
    func testLatitude() {
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 90, longitude: 0.0, placeName: "testName")
        assert(coffeeLocation.getLatitude() <= 90.0)
        assert(coffeeLocation.latitude <= 90.0)
        assert(coffeeLocation.getLatitude() >= -90.0)
        assert(coffeeLocation.latitude >= -90.0)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 90.01, longitude: 0.0, placeName: "testName")
        assert(coffeeLocation.getLatitude() <= 90.0)
        assert(coffeeLocation.latitude <= 90.0)
        assert(coffeeLocation.getLatitude() >= -90.0)
        assert(coffeeLocation.latitude >= -90.0)

        coffeeLocation = CoffeeStoreLocationModel(latitude: -90, longitude: 0.0, placeName: "testName")
        assert(coffeeLocation.getLatitude() <= 90.0)
        assert(coffeeLocation.latitude <= 90.0)
        assert(coffeeLocation.getLatitude() >= -90.0)
        assert(coffeeLocation.latitude >= -90.0)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: -90.01, longitude: 0.0, placeName: "testName")
        assert(coffeeLocation.getLatitude() <= 90.0)
        assert(coffeeLocation.latitude <= 90.0)
        assert(coffeeLocation.getLatitude() >= -90.0)
        assert(coffeeLocation.latitude >= -90.0)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName")
        assert(coffeeLocation.getLatitude() <= 90.0)
        assert(coffeeLocation.latitude <= 90.0)
        assert(coffeeLocation.getLatitude() >= -90.0)
        assert(coffeeLocation.latitude >= -90.0)

    }
    
    func testLongitude() {
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 180, longitude: 180.0, placeName: "testName")
        assert(coffeeLocation.getLongitude() <= 180.0)
        assert(coffeeLocation.longitude <= 180.0)
        assert(coffeeLocation.getLongitude() >= -180.0)
        assert(coffeeLocation.longitude >= -180.0)

        coffeeLocation = CoffeeStoreLocationModel(latitude: 180.01, longitude: 180.01, placeName: "testName")
        assert(coffeeLocation.getLongitude() <= 180.0)
        assert(coffeeLocation.longitude <= 180.0)
        assert(coffeeLocation.getLongitude() >= -180.0)
        assert(coffeeLocation.longitude >= -180.0)

        coffeeLocation = CoffeeStoreLocationModel(latitude: -180, longitude: -180, placeName: "testName")
        assert(coffeeLocation.getLongitude() <= 180.0)
        assert(coffeeLocation.longitude <= 180.0)
        assert(coffeeLocation.getLongitude() >= -180.0)
        assert(coffeeLocation.longitude >= -180.0)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: -180.01, longitude: -180.01, placeName: "testName")
        assert(coffeeLocation.getLongitude() <= 180.0)
        assert(coffeeLocation.longitude <= 180.0)
        assert(coffeeLocation.getLongitude() >= -180.0)
        assert(coffeeLocation.longitude >= -180.0)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName")
        assert(coffeeLocation.getLongitude() <= 180.0)
        assert(coffeeLocation.longitude <= 180.0)
        assert(coffeeLocation.getLongitude() >= -180.0)
        assert(coffeeLocation.longitude >= -180.0)

    }
    
    func testName() {
        let name = "testName"
        let altName = "anotherTestName"
        let charsNumbers = "f459nw349f8n4y5"
        let charsNumbrsSymbols = "ceilyuw4t8%^T&E^&^&%$56t75"
        let address = "123 My Street"
        let price = 10.0
        let priceCents = 100
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: name)
        assert(coffeeLocation.getName() == name)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: name, placeAddress: address)
        assert(coffeeLocation.getName() == name)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: name, placeAddress: address, averagePriceInCents: priceCents)
        assert(coffeeLocation.getName() == name)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: name, placeAddress: address, averagePrice: price)
        assert(coffeeLocation.getName() == name)
        coffeeLocation.setName(newName: name)
        assert(coffeeLocation.getName() == name)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: altName)
        assert(coffeeLocation.getName() == altName)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: altName, placeAddress: address)
        assert(coffeeLocation.getName() == altName)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: altName, placeAddress: address, averagePriceInCents: priceCents)
        assert(coffeeLocation.getName() == altName)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: altName, placeAddress: address, averagePrice: price)
        assert(coffeeLocation.getName() == altName)
        coffeeLocation.setName(newName: altName)
        assert(coffeeLocation.getName() == altName)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: charsNumbers)
        assert(coffeeLocation.getName() == charsNumbers)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: charsNumbers, placeAddress: address)
        assert(coffeeLocation.getName() == charsNumbers)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: charsNumbers, placeAddress: address, averagePriceInCents: priceCents)
        assert(coffeeLocation.getName() == charsNumbers)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: charsNumbers, placeAddress: address, averagePrice: price)
        assert(coffeeLocation.getName() == charsNumbers)
        coffeeLocation.setName(newName: charsNumbers)
        assert(coffeeLocation.getName() == charsNumbers)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: charsNumbrsSymbols)
        assert(coffeeLocation.getName() == charsNumbrsSymbols)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: charsNumbrsSymbols, placeAddress: address)
        assert(coffeeLocation.getName() == charsNumbrsSymbols)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: charsNumbrsSymbols, placeAddress: address, averagePriceInCents: priceCents)
        assert(coffeeLocation.getName() == charsNumbrsSymbols)
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: charsNumbrsSymbols, placeAddress: address, averagePrice: price)
        assert(coffeeLocation.getName() == charsNumbrsSymbols)

        coffeeLocation.setName(newName: charsNumbrsSymbols)
        assert(coffeeLocation.getName() == charsNumbrsSymbols)
        
        coffeeLocation.setName(newName: name)
        assert(coffeeLocation.getName() == name)
        
    }
    
    func testAveragePriceForTwo() {
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName")
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)

        coffeeLocation.setAveragePriceForTwo(newPriceInCents: 100)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)
        coffeeLocation.setAveragePriceForTwo(newPrice: 1.00)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)

        coffeeLocation.setAveragePriceForTwo(newPriceInCents: 1)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)
        coffeeLocation.setAveragePriceForTwo(newPrice: 0.01)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation.setAveragePriceForTwo(newPriceInCents: 0)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)
        coffeeLocation.setAveragePriceForTwo(newPrice: 0.00)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation.setAveragePriceForTwo(newPriceInCents: -0)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)
        coffeeLocation.setAveragePriceForTwo(newPrice: -0.00)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation.setAveragePriceForTwo(newPriceInCents: -1)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)
        coffeeLocation.setAveragePriceForTwo(newPrice: -0.01)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)

        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName", placeAddress: "123 X street",
                                                  averagePrice: 1.00)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName", placeAddress: "123 X street",
                                                  averagePrice: 0.01)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName", placeAddress: "123 X street",
                                                  averagePrice: 0.00)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName", placeAddress: "123 X street",
                                                  averagePrice: -0.00)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName", placeAddress: "123 X street",
                                                  averagePrice: -0.01)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName", placeAddress: "123 X street",
                                                  averagePriceInCents: 100)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName", placeAddress: "123 X street",
                                                  averagePriceInCents: 1)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName", placeAddress: "123 X street",
                                                  averagePriceInCents: 0)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName", placeAddress: "123 X street",
                                                  averagePriceInCents: -0)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: "testName", placeAddress: "123 X street",
                                                  averagePriceInCents: -1)
        assert(coffeeLocation.getAveragePriceForTwo() >= 0)
        assert(coffeeLocation.averagePriceForTwo >= 0)


    }
    
    
    func testAddress()
    {
        let testName = "testName"
        let address = "123 X Street"
        let altAddress = "147A A'la'lepu Road"
        let altAddressSymbols = "191D Z#ara@tea A^e"
        let priceCents = 100
        let price = 1.00
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: testName, placeAddress: address)
        assert(coffeeLocation.getAddress() == address)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: testName, placeAddress: address, averagePriceInCents: priceCents)
        assert(coffeeLocation.getAddress() == address)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: testName, placeAddress: address,
                                                  averagePrice: price)
        assert(coffeeLocation.getAddress() == address)
        
        coffeeLocation.setAddress(newAddress: altAddress)
        assert(coffeeLocation.getAddress() == altAddress)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: testName, placeAddress: altAddress)
        assert(coffeeLocation.getAddress() == altAddress)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: testName, placeAddress: altAddress, averagePriceInCents: priceCents)
        assert(coffeeLocation.getAddress() == altAddress)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: testName, placeAddress: altAddress,
                                                  averagePrice: price)
        assert(coffeeLocation.getAddress() == altAddress)

        coffeeLocation.setAddress(newAddress: altAddressSymbols)
        assert(coffeeLocation.getAddress() == altAddressSymbols)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: testName, placeAddress: altAddressSymbols)
        assert(coffeeLocation.getAddress() == altAddressSymbols)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: testName, placeAddress: altAddressSymbols, averagePriceInCents: priceCents)
        assert(coffeeLocation.getAddress() == altAddressSymbols)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: testName, placeAddress: altAddressSymbols,
                                                  averagePrice: price)
        assert(coffeeLocation.getAddress() == altAddressSymbols)
        
        coffeeLocation.setAddress(newAddress: address)
        assert(coffeeLocation.getAddress() == address)
    }
    
    func testDistance() {
        let testName = "testName"
        coffeeLocation = CoffeeStoreLocationModel(latitude: 0.0, longitude: 0.0, placeName: testName)
        
        coffeeLocation.setDistance(location: CLLocation(latitude: 0.0, longitude: 0.0))
        assert(coffeeLocation.getDistance() == 0)
        
        
        coffeeLocation.setDistance(location: CLLocation(latitude: 10.0, longitude: 0.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 1105854833)
        assert(Int(coffeeLocation.distance * 1000.0) == 1105854833)
        
        coffeeLocation.setDistance(location: CLLocation(latitude: 0.0, longitude: 10.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 1113194907)
        assert(Int(coffeeLocation.distance * 1000.0) == 1113194907)

        
        coffeeLocation.setDistance(location: CLLocation(latitude: 10.0, longitude: 10.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 1565109099)
        assert(Int(coffeeLocation.distance * 1000.0) == 1565109099)

        
        coffeeLocation.setDistance(location: CLLocation(latitude: 0.0, longitude: 30.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 3339584723)
        
        assert(Int(coffeeLocation.distance * 1000.0) == 3339584723)
        
        coffeeLocation.setDistance(location: CLLocation(latitude: 45.0, longitude: 30.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 5794989428)
        
        assert(Int(coffeeLocation.distance * 1000.0) == 5794989428)

        coffeeLocation.setDistance(location: CLLocation(latitude: 90.0, longitude: 30.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 10001965729)
        
        assert(Int(coffeeLocation.distance * 1000.0) == 10001965729)

        coffeeLocation.setDistance(location: CLLocation(latitude: 30.0, longitude: 0.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 3320113397)
        
        assert(Int(coffeeLocation.distance * 1000.0) == 3320113397)

        coffeeLocation.setDistance(location: CLLocation(latitude: 30.0, longitude: 45.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 5805113684)
        
        assert(Int(coffeeLocation.distance * 1000.0) == 5805113684)

        coffeeLocation.setDistance(location: CLLocation(latitude: 30.0, longitude: 90.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 10014576829)
        
        assert(Int(coffeeLocation.distance * 1000.0) == 10014576829)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 45.0, longitude: 0.0, placeName: testName)
        coffeeLocation.setDistance(location: CLLocation(latitude: 45.0, longitude: 0.0))
        assert(coffeeLocation.getDistance() == 0)
        
        assert(coffeeLocation.distance == 0)
        
        coffeeLocation.setDistance(location: CLLocation(latitude: 45.0, longitude: 45.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 3501260158)
        
        assert(Int(coffeeLocation.distance * 1000.0) == 3501260158)

        coffeeLocation.setDistance(location: CLLocation(latitude: 45.0, longitude: 90.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 6690232932)
        
        assert(Int(coffeeLocation.distance * 1000.0) == 6690232932)
        
        coffeeLocation = CoffeeStoreLocationModel(latitude: 90.0, longitude: 0.0, placeName: testName)
        coffeeLocation.setDistance(location: CLLocation(latitude: 90.0, longitude: 0.0))
        assert(coffeeLocation.getDistance() == 0)
        
        assert(coffeeLocation.distance == 0)
        
        coffeeLocation.setDistance(location: CLLocation(latitude: 90.0, longitude: 45.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 0)
        
        assert(Int(coffeeLocation.distance * 1000.0) == 0)
        
        coffeeLocation.setDistance(location: CLLocation(latitude: 90.0, longitude: 90.0))
        assert(Int(coffeeLocation.getDistance() * 1000.0) == 0)
        
        assert(Int(coffeeLocation.distance * 1000.0) == 0)

    }
}
