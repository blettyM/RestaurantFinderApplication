//
//  RestaurantURLManager.swift
//  FindRestaurantApp
//
//  Created by Bletty Jans on 03/04/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation

class RestaurantURLManager
{
    class func getCityRestuarantURL(lat: Double ,long: Double) -> URL?
    {
        
        let latitude = lat
        let longitude = long
        
       // let urlString = "https://api.yelp.com/v3/businesses/search?term=restaurants&location=\(cityName)"
        
         let newUrlString = "https://api.yelp.com/v3/businesses/search?term=restaurants&latitude=\(latitude)&longitude=\(longitude)"
        
         print(newUrlString)
        
        return URL(string: newUrlString)
}
    
    class func getAccessTokenURL() -> URL?
    {
        let urlString = "https://api.yelp.com/oauth2/token?grant_type=oauth2&client_id=GzQ3DYE_hYEYrfKOjeqvhA&client_secret=kiQq8jJw2LDuhIdjX7SusYgBxBVYIDsaSuwUOLHjYPgmxKmBT69erEepArC4yUnj"
        
        return URL(string: urlString)
    }
    
    class func getBusinessesURL(itemId: String) -> URL?
    
    {
       let urlString = "https://api.yelp.com/v3/businesses/\(itemId)"
        
        print("string---",urlString)
        
        return URL(string: urlString)
    
    }
    
    class func getReviewURL(itemId: String) -> URL?
        
    {
        let reviewUrlString = "https://api.yelp.com/v3/businesses/\(itemId)/reviews"
        
        
        print("reviewUrlString---",reviewUrlString)
        
        return URL(string: reviewUrlString)
        
    }

    
}
