//
//  RestaurantTableViewCell.swift
//  RestaurantFinder
//
//  Created by Bletty Jans on 05/04/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import UIKit

class RestaurantTableViewCell : UITableViewCell

{
    
    @IBOutlet weak var imageIconView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var displayAddressLabel: UILabel!
    @IBOutlet weak var displayAddressLabel1: UILabel!
    @IBOutlet weak var displayAddressLabel2: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    func setRestaurantDetails(restaurantData: RestaurantData)
    {
        self.nameLabel.text = restaurantData.restaurantName
        self.phoneNumberLabel.text = restaurantData.phoneNumber
        self.ratingLabel.text = restaurantData.rating
        
        let value = Int(round(restaurantData.distance))
        self.distanceLabel.text = "\(value)" + " KM"
        
        self.displayAddressLabel.text = restaurantData.displayAddress1
        self.displayAddressLabel1.text = restaurantData.displayAddress2
        self.displayAddressLabel2.text = restaurantData.displayAddress3
       
        
        if let iconURL = URL(string: restaurantData.image)
        
        {
          self.imageIconView.loadImage(url: iconURL)
        }
        
    }
    

}
