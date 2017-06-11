//
//  RestaurantData.swift
//  FindRestaurantApp
//
//  Created by Bletty Jans on 04/04/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import  UIKit

class RestaurantData
{
    let restaurantId: String
    let restaurantName: String
    let phoneNumber: String
    let rating: String
    let distance: Double
    let displayAddress1: String
    let displayAddress2: String
    let displayAddress3: String
   
    let image: String
    
    
    init(dataJSON: JSON)
    {
        self.restaurantId = dataJSON["id"].stringValue
        self.restaurantName = dataJSON["name"].stringValue
        self.phoneNumber = dataJSON["display_phone"].stringValue
        
        self.rating = dataJSON["rating"].stringValue
        
        
        self.distance = dataJSON["distance"].doubleValue
        
        self.displayAddress1 = dataJSON["location"]["display_address"][0].stringValue
        self.displayAddress2 = dataJSON["location"]["display_address"][1].stringValue
        self.displayAddress3 = dataJSON["location"]["country"].stringValue
      
        image = dataJSON["image_url"].stringValue
        
      
    }
}

