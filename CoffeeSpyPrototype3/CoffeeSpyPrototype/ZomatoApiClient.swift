//
//  ZomatoApiClient.swift
//  CoffeeSpyPrototype
//
//  Created by Roland Askew on 5/4/17.
//  Copyright © 2017 team godzilla. All rights reserved.
//

import Foundation
import UIKit


class ZomatoApiClient {
    
    var userKey: String?
    
    var query: String?
    var latitude: Double?
    var longitude: Double?
    var itemCount: Int?
    var maxRadius: Int?
    var sortItem: String?
    var sortOrder: String?
    
    var restaurant: NSDictionary?
    
    var responseCompleted: Bool = false
    
    var session : URLSession?
    
    weak var delegate:ApiClientCallbackDelegate?
    
    
    /***
     *  create the client object, with  user (api) key
     *  key cannot be changed during the lifecycle of the client object.
     */
    init( user key : String )
    {
        self.userKey = key;
    }
    
    func getUserKey() -> String
    {
        return self.userKey!
    }
    
    func setQuery(query : String)
    {
        self.query = query;
    }
    func getQuery() -> String
    {
        return self.query!
    }
    
    func setLatitude(latitude : Double)
    {
        self.latitude = latitude;
    }
    func getLatitude() -> Double
    {
        return self.latitude!
    }
    
    func setLongitude(longitude : Double)
    {
        self.longitude = longitude;
    }
    func getLongitude() -> Double
    {
        return self.longitude!
    }
    
    func setItemCount(itemCount : Int)
    {
        self.itemCount = itemCount;
    }
    func getItemCount() -> Int
    {
        return self.itemCount!
    }
    
    func setMaxRadius(maxRadius : Int)
    {
        self.maxRadius = maxRadius;
    }
    func getMaxRadius() -> Int
    {
        return self.maxRadius!
    }
    
    func setSortItem(sortItem : String)
    {
        self.sortItem = sortItem;
    }
    func getSortItem() -> String
    {
        return self.sortItem!
    }
    
    func setSortOrder(sortOrder : String)
    {
        self.sortOrder = sortOrder;
    }
    func getSortOrder() -> String
    {
        return self.sortOrder!
    }
    
    func setDelegate( callbackDelegate: ApiClientCallbackDelegate)
    {
        self.delegate = callbackDelegate
    }
    
    func getResponseCompleted() -> Bool
    {
        return self.responseCompleted
    }
    
    func sendRequest()
    {
        self.responseCompleted = false;
        let urlString = "https://developers.zomato.com/api/v2.1/search?q=\(self.getQuery())&count=\(self.getItemCount())&lat=\(self.getLatitude())&lon=\(self.getLongitude())&radius=\(self.getMaxRadius())&sort=\(self.getSortItem())&order=\(self.getSortOrder())";
        print("New Request: \(urlString)")
        let url = URL(string: urlString)
        
        if url != nil {
            let request = NSMutableURLRequest(url: url! as URL)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(self.getUserKey(), forHTTPHeaderField: "user_key")
            
            session = URLSession.shared
            
            let responseHandler: (Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
                if error == nil {
                    let httpResponse = response as! HTTPURLResponse!
                    
                    if httpResponse?.statusCode == 200 {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                if let restaurants = json["restaurants"] as? [NSDictionary] {
                                    print("Response converted to [NSDictionary]")
                                    self.delegate?.didFinishApiCall(sender: self, results: restaurants)
                                }
                            }
                            
                        } catch {
                            print(error)
                            //delegate.generalError( sender: self )
                        }
                        
                        self.responseCompleted = true;
                    }
                    else
                    {
                        self.responseCompleted = true;
                        //delegate.generalError( sender: self )
                    }
                    
                    print("Response processed, status=\(httpResponse?.statusCode)")
                    
                    self.session?.finishTasksAndInvalidate()
                }
            }
            
            let task = session?.dataTask(with: request as URLRequest, completionHandler: responseHandler)
            
            task?.resume()
        }
    }
    
    /***
     *  frees resources and prevents further use of the client object.
     */
    func stop()
    {
        // dispose of any temporary resources
    }
}
