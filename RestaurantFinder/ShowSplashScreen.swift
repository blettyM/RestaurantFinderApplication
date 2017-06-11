//
//  ShowSplashScreen.swift
//  RestaurantFinder
//
//  Created by Bletty Jans on 04/04/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import UIKit

class ShowSplashScreen : UIViewController

{
    override func viewDidLoad() {
        
        perform(#selector(showNavContoller), with: nil, afterDelay: 2.0)
    
    }
    
    func showNavContoller()  {
    
        performSegue(withIdentifier: "showSplash", sender: AnyObject.self)
        
    }

}
