//
//  DetailViewController.swift
//  RestaurantFinder
//
//  Created by Bletty Jans on 05/04/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController : UICollectionViewController,UICollectionViewDelegateFlowLayout
    
{
    var itemId : String!
    var tokenId : String = ""
    var businessesArray : Array<CollectionData>?
    var reviewArray : Array<ReviewData>?
    var flag = false

    
    override func viewDidLoad() {
        
      
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        
       
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.collectionView?.backgroundColor = UIColor.blue
        collectionView!.collectionViewLayout = layout
        
        layout.sectionHeadersPinToVisibleBounds = true
        layout.headerReferenceSize = CGSize(width:((self.collectionView?.frame.size.width)!-20), height: 40)
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! HeaderReusableView
            
            headerView.backgroundColor = UIColor.yellow;
            
            
            headerView.layer.cornerRadius = 1.0;
            
            headerView.layer.borderWidth = 2.0;
            headerView.layer.borderColor = UIColor.brown.cgColor;
            
            let myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
            
            headerView.layer.shadowColor = myColor.cgColor
            headerView.layer.shadowOpacity = 1.0;
            headerView.layer.shadowRadius = 1.0;
            headerView.layer.shadowOffset = CGSize(width: 0, height: 3)
            
            
            if flag == false
            
            {
                 headerView.isHidden = true
            }
            
            else
                
            {
              headerView.isHidden = false
            }
            
            if indexPath.section == 0
                
            {
            
            headerView.headerLabel.text = "Photos"
           
            return headerView
                
            }
            
            headerView.headerLabel.text = "Reviews"
            
            return headerView
            
    
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize

    {
    
        let width = UIScreen.main.bounds.width
        
        let height1 = UIScreen.main.bounds.height
        
        
        
        
        if indexPath.section == 0
        {
            return CGSize(width: width, height: height1/2)
        }
        
        return CGSize(width: width, height: height1/6);
        
    }

    
    
    
    func setDetails(itemName: String)
    
    {
    
        
        self.itemId = itemName
        self.tokenId = UserDefaults.standard.string(forKey: "tokenID")!
        
        print("tokenID-----------",self.tokenId)
        
        if let restaurantBusinessesURL = RestaurantURLManager.getBusinessesURL(itemId: self.itemId)
            
        {
           
            
            var request1 = URLRequest(url: restaurantBusinessesURL)
            
            request1.setValue("Bearer \(tokenId)", forHTTPHeaderField: "Authorization")
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
                    
                    print("number--",details["display_phone"].stringValue)
                    
                    self.parseJSON (json: details)
                    
                    DispatchQueue.main.async
                        {
                            self.flag = true
                            self.collectionView?.reloadData()
            
                        }
                    
                }
            }
            
            task.resume()
            
            
        }
        
        
        if let restaurantReviewURL = RestaurantURLManager.getReviewURL(itemId: self.itemId)
        
        {
            
            
            var request2 = URLRequest(url: restaurantReviewURL)
            
            request2.setValue("Bearer \(tokenId)", forHTTPHeaderField: "Authorization")
            request2.httpMethod = "GET"
            
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request2)
            { (data, response, error) -> Void in
                
                
                if error != nil {
                    
                    print(error!.localizedDescription)
                    
                }
                    
                else if data != nil
                    
                {
                    // Load Temperature
                    let details = JSON(data: data!)
                    
                    self.parseJSON1 (json: details)
                    
                    DispatchQueue.main.sync
                        {
                            //self.flag = true
                            //self.collectionView?.reloadData()
                            
                    }
                    
                }
            }
            
            task.resume()
            
            
        }

    }
    
    func parseJSON(json: JSON) {
        
        
        businessesArray = Array<CollectionData>()
        businessesArray?.append(CollectionData(dataJSON: json))
         
    }
    
    
    func parseJSON1(json: JSON) {
        
        
        reviewArray = Array<ReviewData>()
        
        let reviews = json["reviews"].arrayValue // from json file
        
        for Data in reviews
            
        {
            
            reviewArray?.append(ReviewData(dataJSON1: Data))
            
            
        }
        
        
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if section == 0 {
            
            
            return businessesArray?.count ?? 0
        }
            
        
        else if section == 1{
        

            return reviewArray?.count ?? 0
        }
        
        return 0
    }
    
    

    
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        
    {
       // self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
       // let cellidentifier = (indexPath.section == 0) ? "firstCell" : "reviewCell"
        
        
        
       var cell = UICollectionViewCell()
        
        let cellA:DetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! DetailCollectionViewCell
        let cellB:ReviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        let section = indexPath.section
        
        if section == 0 {
            
             cellA.setRestaurantViewDetails(resData: (self.businessesArray?[indexPath.row])!)
             cell = cellA
            
            //end of section 0
        } else if section == 1 {
            
             cellB.setReviewDetails(reviewData: (self.reviewArray?[indexPath.row])!)
             cell = cellB
            
            cell = cellB
        }
        
      //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellidentifier, for: indexPath) as! DetailCollectionViewCell
        

        return cell
        
    }
    
    
}
