//
//  CollectionData.swift
//  RestaurantFinder
//
//  Created by Bletty Jans on 05/04/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import UIKit

class CollectionData

{
        let restaurantId: String
        let restaurantName: String
        let phoneNumber: String
    
        
        var resImageArray = Array<String>()
  
        
        
        init(dataJSON: JSON)
        {
            self.restaurantId = dataJSON["id"].stringValue
            self.restaurantName = dataJSON["name"].stringValue
            self.phoneNumber = dataJSON["display_phone"].stringValue
            
            print("phoneNumber----",phoneNumber)
            
          
        
            let imageArray = dataJSON["photos"].arrayValue // from json file
            
            for element in imageArray
                
            {
                
                resImageArray.append(element.stringValue)
                print(element.stringValue)
                
                
            }
            
            
        }
    }



