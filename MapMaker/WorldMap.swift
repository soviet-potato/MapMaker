//
//  WorldMap.swift
//  MapMaker
//
//  Created by Cameron Martin on 2/27/17.
//  Copyright © 2017 Samuil Agranovich. All rights reserved.
//

import Foundation
import UIKit

class WorldMap {
    let height: Int
    let width: Int
    var landforms: UIImage
    var background: UIImage
	var political: UIImage
	var icons: UIImage
    
    init(width: Int, height: Int) {
        self.height = height
        self.width = width
        self.background = UIImage(color: UIColor.blue, size: CGSize(width: self.width, height: self.height))!
        self.landforms = self.background
		self.political = UIImage()
		self.icons = UIImage()
    }
}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
