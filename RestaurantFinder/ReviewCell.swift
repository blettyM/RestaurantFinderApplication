//
//  ReviewCell.swift
//  RestaurantFinder
//
//  Created by Bletty Jans on 2017-06-09.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import  UIKit

class ReviewCell : UICollectionViewCell
    
{

    
    @IBOutlet weak var descriptionTextView: UITextView!
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
    
}
