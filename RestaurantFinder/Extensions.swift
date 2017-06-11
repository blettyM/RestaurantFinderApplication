//
//  Extensions.swift
//  News Application
//
//  Created by Peter Rutherford on 2016-11-06.
//  Copyright © 2016 cs2680. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
	func loadImage(url: URL?)
	{
		self.image = nil

		if url != nil
		{
			let task = URLSession.shared.dataTask(with: url!)
			{ (data, response, error) in
				
				DispatchQueue.main.async
				{
					if data != nil && error == nil
					{
						if let image = UIImage(data: data!)
						{	self.image = image
						}
					}
				}
			}

			task.resume()
		}
	}
}
