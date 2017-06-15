//
//  RestaurantTableViewController.swift
//  FindRestaurantApp
//
//  Created by Bletty Jans on 04/04/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class RestaurantTableViewController : UITableViewController,CLLocationManagerDelegate
    
{
    
    var tokenID : String = ""
    var restaurantArray: Array<RestaurantData>?
    
   // var resSearchResults:Array<RestaurantData>?
    
    var locationManager:CLLocationManager!
    
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
  
    
   
    var dataArray =  Array<String>()
    
    var filteredArray = [String]()
    
    var shouldShowSearchResults = false
   
    
    override func viewDidLoad() {
        
        print("helloooo----")
        
        
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView?.refreshControl?.addTarget(self, action: #selector(RestaurantTableViewController.reloadData), for: .valueChanged)
       // configureSearchController()
      
    }
    
//    func configureSearchController() {
//        
//        searchController = UISearchController(searchResultsController: nil)
//      
//        searchController.dimsBackgroundDuringPresentation = true
//        searchController.searchBar.placeholder = "Search here..."
//        searchController.searchBar.delegate = self
//    }
 
    override func viewWillAppear(_ animated: Bool)
    {
        determineMyCurrentLocation()
        
    }
    
    
    
    func determineMyCurrentLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
     
            
            if self.latitude != userLocation.coordinate.latitude && self.longitude != userLocation.coordinate.longitude {
                
                self.latitude = userLocation.coordinate.latitude
                self.longitude = userLocation.coordinate.longitude
                self.reloadData()
            
            }
            
           
        
        
        

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    func reloadData()
    {
        //let source = UserDefaults.standard.string(forKey: "news_source")
        
        if let tokenURL = RestaurantURLManager.getAccessTokenURL()
            
        {
            
            var request = URLRequest(url: tokenURL)
            request.httpMethod = "POST"
            let postString : String = "uid=59"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request)
            { (data, response, error) -> Void in
                
                
                if error != nil {
                    print(error!.localizedDescription)
                }
                    
                else if data != nil
                    
                {
                    // Load token
                    let accessToken = JSON(data: data!)
                    
                    self.tokenID = accessToken["access_token"].stringValue
                    
                    UserDefaults.standard.set(self.tokenID, forKey: "tokenID")
                    
                    DispatchQueue.main.async
                        {
                            print("test---")
                            print(self.tokenID)
                            self.getCityRestuarants(token: self.tokenID)
                            
                    }
                }
            }
            
            task.resume()
            
    
        }
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return restaurantArray?.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restaurantArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! RestaurantTableViewCell
        cell.setRestaurantDetails(restaurantData: (self.restaurantArray?[indexPath.row])!)
        
        return cell
    }
    
    
    
    func getCityRestuarants(token: String)
        
    {
        
        let tokenValue = token
    
        
        if let cityRestaurantsURL = RestaurantURLManager.getCityRestuarantURL(lat: latitude,long: longitude)
            
        {
            
            var request1 = URLRequest(url: cityRestaurantsURL)
            request1.setValue("Bearer \(tokenValue)", forHTTPHeaderField: "Authorization")
            request1.httpMethod = "GET"
            
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request1)
            { (data, response, error) -> Void in
                
                
                if error != nil {
                    print(error!.localizedDescription)
                }
                    
                else if data != nil
                    
                {
                    // Load Temperature
                    let details = JSON(data: data!)
                    
                    self.parseJSON (json: details)
                    
                    DispatchQueue.main.async
                        {
                            
                            
                            self.tableView?.refreshControl?.endRefreshing()
                            self.tableView?.reloadData()
                    }
                    
                }
            }
            
            task.resume()
            
            
        }
            
        else
        {
            self.tableView?.refreshControl?.endRefreshing()
        }
        
    }
    
    
    func parseJSON(json: JSON) {
        
        
        restaurantArray = Array<RestaurantData>()
        
        let restaurants = json["businesses"].arrayValue // from json file
        
        for Data in restaurants
            
        {
            
            restaurantArray?.append(RestaurantData(dataJSON: Data))
            
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailView = segue.destination as! DetailViewController
        
        let itemIndexPath = self.tableView.indexPath(for: (sender as! UITableViewCell))!
        detailView.navigationItem.title = restaurantArray![itemIndexPath.row].restaurantName
        
        detailView.setDetails(itemName: restaurantArray![itemIndexPath.row].restaurantId)
        
    }


}






