//
//  DetailViewController.swift
//  CoffeeSpyPrototype
//
//  Created by Roland Askew on 4/11/17.
//  Copyright © 2017 team godzilla. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var detailMap: MKMapView!
    @IBOutlet weak var routeSelector: UISegmentedControl!
    
    var destination : CLLocation?
    var userLocation : CLLocation?
    
    let locationManager = CLLocationManager()
    
    var targetMKRegion: MKCoordinateRegion?
    var targetMKItem: MKMapItem?
    
    var routeOverlay: MKOverlay?
    
    var routeType: MKDirectionsTransportType?
    
    func configureView() {
        if let detail = self.detailItem {
            destination = CLLocation(latitude: detail.latitude, longitude: detail.longitude)
        }
    }
    
    // move the map centre to the marker (coffee location)
    func recenterLocation(_ sender: Any) {
        detailMap.setRegion(targetMKRegion!, animated: true)
    }
    
    // update the shown route in real time as the user moves.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        
        self.clearRoute()
        if (userLocation != nil) {
            handleRouteUpdate()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        // nav button to recenter map on the marker
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "reset_map.png"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(recenterLocation(_:)), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        detailMap.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        // map item for coffee location
        if #available(iOS 10.0, *) {
            targetMKItem = MKMapItem(placemark: MKPlacemark(coordinate: (destination?.coordinate)!))
            targetMKRegion = MKCoordinateRegionMakeWithDistance((destination?.coordinate)!, 500, 500)
        } else if #available(iOS 8.0, *) {
            let placemark = MKPlacemark(coordinate: (destination?.coordinate)!, addressDictionary: nil)
            targetMKItem = MKMapItem(placemark: placemark)
            targetMKRegion = MKCoordinateRegionMakeWithDistance((destination?.coordinate)!, 500, 500)
        }
        
        routeSelector.selectedSegmentIndex = 0
        routeSelectorDidTap(self)
        
        self.detailMap.delegate = self
    }
    
    // update user location when view is visible
    override func viewDidAppear(_ animated: Bool) {
        
        let annotation = AnnotationImpl(title: (detailItem?.getName())!, subtitle: (detailItem?.getAddress())!, coordinate: (destination?.coordinate)!)
        detailMap.addAnnotation(annotation)
        
        if #available(iOS 9.0, *) {
            detailMap.showsScale = true
        } else {
            // Don't show scale - not available.
        }
        
        recenterLocation(self)
    }
    
    // only update user location while view is visible
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // the model for the coffee location
    var detailItem: CoffeeStoreLocationModel? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func clearRoute() {
        if (self.routeOverlay != nil)
        {
            self.detailMap.remove(self.routeOverlay!)
        }
    }
    
    // manages updating the currently shown route, on the map
    // does not remove old overlays - tha has to be done before this method is called.
    func handleRouteUpdate()
    {
        let directionRequest = MKDirectionsRequest()
        
        if #available(iOS 10.0, *) {
            directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: (userLocation?.coordinate)!))
        } else if #available(iOS 8.0, *) {
            let placemark = MKPlacemark(coordinate: (userLocation?.coordinate)!, addressDictionary: nil)
            directionRequest.source = MKMapItem(placemark: placemark)
        }
        
        directionRequest.destination = self.targetMKItem!
        directionRequest.transportType = self.routeType!
        
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            (response, error) -> Void in
            
            guard response != nil else { return }
            
            if ((response?.routes.count)! > 0)
            {
                self.routeOverlay = (response?.routes[0].polyline)!
                
                self.detailMap.add(self.routeOverlay!, level: MKOverlayLevel.aboveRoads)
            }
        }
    }
    
    // which type of route to show.
    @IBAction func routeSelectorDidTap(_ sender: Any) {
        let value = routeSelector.selectedSegmentIndex
        
        switch (value)
        {
        case RouteSelection.car.rawValue:
            self.routeType = .automobile
        case RouteSelection.car.rawValue:
            self.routeType = .walking
        default:
            self.routeType = .walking
        }
        
        // requested route type was changed - so update it
        self.clearRoute()
        if (userLocation != nil) {
            handleRouteUpdate()
        }
    }
    
    // actually draws the route. the containing class must implement MKMapViewDelegate.
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 3.0
        return renderer
    }
    
}

