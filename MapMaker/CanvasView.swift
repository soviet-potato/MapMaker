//
//  CanvasView.swift
//  MapMaker
//
//  Created by Cameron Martin on 2/27/17.
//  Copyright © 2017 Samuil Agranovich. All rights reserved.
//

import UIKit

class CanvasView: UIImageView {
    
    var currentMap = WorldMap(width: 800, height: 800)
    var bg = UIImageView()
    var lf = UIImageView()
	
	let layers = Dictionary<Int, UIImageView>()
	
    func setBackgroundLayer() -> UIImageView {
        let bg = currentMap.background
        let layer = UIImageView()
        layer.image = bg
        addSubview(layer)
        layer.isOpaque = true
        layer.frame = CGRect(x: 0, y: 0, width: currentMap.width, height: currentMap.height)
        return layer
    }
    
    func setLandformsLayer() -> UIImageView {
        let lf = currentMap.landforms
        let layer = UIImageView()
        layer.image = lf
        addSubview(layer)
        layer.isOpaque = true
        layer.frame = CGRect(x: 0, y: 0, width: currentMap.width, height: currentMap.height)
        return layer
    }
    
    func drawMap() {
        bg = setBackgroundLayer()
        lf = setLandformsLayer()
    }
	
	

}
