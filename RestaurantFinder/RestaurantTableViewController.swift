//
//  RestaurantTableViewController.swift
//  FindRestaurantApp
//
//  Created by Bletty Jans on 04/04/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import UIKit

class RestaurantTableViewController : UITableViewController
    
{
    
    var tokenID : String = ""
    var restaurantArray: Array<RestaurantData>?
    
    override func viewDidLoad() {
        
        print("helloooo----")
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView?.refreshControl?.addTarget(self, action: #selector(RestaurantTableViewController.reloadData), for: .valueChanged)
        
      
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.reloadData()
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
        
        let cityName = "Scarborough"
        
        if let cityRestaurantsURL = RestaurantURLManager.getCityRestuarantURL(city: cityName)
            
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






