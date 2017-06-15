//
//  DetailCollectionViewCell.swift
//  RestaurantFinder
//
//  Created by Bletty Jans on 05/04/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import  UIKit

class DetailCollectionViewCell : UICollectionViewCell
    
{
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var resImageView: UIImageView!
    
    
    
   /* @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func setReviewDetails(reviewData: ReviewData)
    {
       
        
        self.authorLabel.text = reviewData.reviewerName
        self.descriptionTextView.text = reviewData.text
        
     
        if let reviewerImageURL = URL(string: reviewData.reviewerImage)
            
        {
            self.imageView.loadImage(url: reviewerImageURL)
        }

        
    }
 
 */
    
    func setRestaurantViewDetails(resData: CollectionData)
    {
        
        
         self.headlineLabel.text = resData.restaurantName
        // self.headlineLabel.text = resData.restaurantId
         self.detailsLabel.text = resData.phoneNumber
        
       // for Data in resData.resImageArray{
            
             let resImageURL = URL(string:resData.resImageArray[0])
                
           // {
                self.resImageView.loadImage(url: resImageURL)
           // }
            
       // }
        
       
        
        
    }
}
