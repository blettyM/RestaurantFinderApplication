//
//  ReviewData.swift
//  RestaurantFinder
//
//  Created by Bletty Jans on 2017-06-07.
//  Copyright © 2017 cs2680. All rights reserved.
//
import Foundation
import UIKit

class ReviewData
    
{
    let reviewerName: String
    let text: String
    
    let reviewerImage: String
    
    
    init(dataJSON1: JSON)
    {
        self.reviewerName = dataJSON1["user"]["name"].stringValue
        self.text = dataJSON1["text"].stringValue
    
        self.reviewerImage = dataJSON1["user"]["image_url"].stringValue
        
        
    }
}



