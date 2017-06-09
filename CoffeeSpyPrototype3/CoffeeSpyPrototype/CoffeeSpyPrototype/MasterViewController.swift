//
//  MasterViewController.swift
//  CoffeeSpyPrototype
//
//  Created by Roland Askew on 4/11/17.
//  Copyright © 2017 team godzilla. All rights reserved.
//

import UIKit
import CoreLocation

class MasterViewController: UITableViewController, CLLocationManagerDelegate, ApiClientCallbackDelegate {
    
    let apiKey = "7e6db2d09bc8880b989392b8d2e1e75b"
    let maxRadiusMetres = 1000
    let queryContent = "coffee"
    let sortOrder = "asc"
    let maxCountItems = 20
    let sortItemCost = "cost"
    let sortItemDistance = "real_distance"

    var detailViewController: DetailViewController? = nil
    var objects = [CoffeeStoreLocationModel]()

    var isOrderedByPrice: Bool = true
    
    var userLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    
    var apiClient : ZomatoApiClient?
    
    let locationManager = CLLocationManager()
    
    let distanceFilterAmount = 10.0
    let headingFilterAmount = CLLocationDegrees(30)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiClient = ZomatoApiClient(user: apiKey)
        apiClient!.setQuery(query: queryContent)
        apiClient!.setItemCount(itemCount: 20)
        apiClient!.setMaxRadius(maxRadius: maxRadiusMetres)
        apiClient!.setSortOrder(sortOrder: sortOrder)
        apiClient!.setDelegate(callbackDelegate: self)
        
        locationManager.delegate = self
        locationManager.distanceFilter = distanceFilterAmount
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeOrdering(_:)))

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // only update location while view is visible
    override func viewDidAppear(_ animated: Bool) {
        

        locationManager.startUpdatingLocation()
        
    }
    
    //MARK: helper methods to sync table View and backend model collection
    
    func clearCoffeeLocations()
    {
        objects.removeAll()
        tableView.reloadData()
    }
    
    // attach model to end of collection and table view
    func appendCoffeeLocation(coffeeLocation: CoffeeStoreLocationModel)
    {
        objects.append(coffeeLocation)
        let ndx = objects.count - 1
        let indexPath = IndexPath(row: ndx, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func removeCoffeeLocation(index: Int) -> CoffeeStoreLocationModel
    {
        let coffeeLocation = objects.remove(at: index)
        let ndx = objects.count - 1
        let indexPath = IndexPath(row: ndx, section: 0)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        return coffeeLocation
    }
    
    // like append, but inserted at a given index.
    // WARNING: does not check for outOfBounds. That's up to the method invoking this helper.
    func addCoffeeLocation(index: Int, coffeeLocation: CoffeeStoreLocationModel)
    {
        objects.insert(coffeeLocation, at: index)
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    //MARK: api calls
    
    func beginApiRequest(_ sender: Any)
    {
        
        apiClient?.setLatitude(latitude: (userLocation.coordinate.latitude))
        apiClient?.setLongitude(longitude: (userLocation.coordinate.longitude))
        
        if (isOrderedByPrice)
        {
            apiClient?.setSortItem(sortItem: sortItemCost)
        }
        else
        {
            apiClient?.setSortItem(sortItem: sortItemDistance)
        }
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false;

        apiClient?.sendRequest()
        
    }
    
        // delegated method for when the ApiClient gives results.
    func didFinishApiCall(sender: Any, results : [NSDictionary])
    {
        clearCoffeeLocations()
        
        var tmpCoffeeLocations = [CoffeeStoreLocationModel]()
        
        // transform the Dictionary results into coffeestorelocationmodels
        // clear the model list, reload table.
        // load models into the list
        // at same time update the table with each model loaded.
        for result in results
        {
            let restaurant = result["restaurant"] as! NSDictionary
            let placeName = restaurant["name"] as! String
            let cost = restaurant["average_cost_for_two"] as! Int
            let location = restaurant["location"] as! NSDictionary
            let address   = location["address"] as! String
            let latitude  = location["latitude"] as! String
            let longitude = location["longitude"] as! String
            let item = CoffeeStoreLocationModel(latitude: Double(latitude)!, longitude: Double(longitude)!, placeName: placeName, placeAddress: address, averagePrice: Double(cost))
            item.setDistance(location: userLocation)
            
            tmpCoffeeLocations.append(item)
        }
        
        if (isOrderedByPrice)
        {
            tmpCoffeeLocations.sort(by: {$0.averagePriceForTwo < $1.averagePriceForTwo})
        }
        else
        {
            
            tmpCoffeeLocations.sort(by: {$0.distance < $1.distance})
            
        }
        
        for coffee in tmpCoffeeLocations
        {
            appendCoffeeLocation(coffeeLocation: coffee)
        }
        
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                locationManager.stopUpdatingLocation()
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    //reorder by price or distance
    func changeOrdering(_ sender: Any)
    {
        isOrderedByPrice = !isOrderedByPrice
        
        var tmpCoffeeLocations = [CoffeeStoreLocationModel]()
        for coffeeLocation in objects
        {
            tmpCoffeeLocations.append(coffeeLocation)
        }
        
        clearCoffeeLocations()
        
        if (isOrderedByPrice)
        {
            tmpCoffeeLocations.sort(by: {$0.averagePriceForTwo < $1.averagePriceForTwo})
        }
        else
        {
            
            tmpCoffeeLocations.sort(by: {$0.distance < $1.distance})
            
        }
        
        for coffeeLocation in tmpCoffeeLocations
        {
            appendCoffeeLocation(coffeeLocation: coffeeLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        beginApiRequest(self)
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object.getName()
        if (isOrderedByPrice)
        {
            cell.detailTextLabel!.text = String(format:"$%.2f", object.getAveragePriceForTwo())
        }
        else
        {
            cell.detailTextLabel!.text = String(format:"%.0f m", object.getDistance())
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}

