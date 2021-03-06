//
//  CanvasView.swift
//  MapMaker
//
//  Created by Cameron Martin on 2/27/17.
//  Copyright © 2017 Samuil Agranovich. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var currentMap = WorldMap(width: 1000, height: 800)
	
	//0 is background, 1 is landforms, 2 is political, 3 is icons
	var layers = [UIImageView(), UIImageView(), UIImageView(), UIImageView()]
	
	func populateLayersFromMap() {
		layers[0].image = currentMap.background
		layers[1].image = currentMap.landforms
		//layers[2].image = currentMap.political
		//layers[3].image = currentMap.icons
	}
	
	override func draw(_ rect: CGRect) {
		drawLayerInCanvas(image: layers[0])
		drawLayerInCanvas(image: layers[1])
	}
	
	func drawLayerInCanvas(image: UIImageView) {
		let startX = Int(self.center.x) - currentMap.width / 2
		let startY = Int(self.center.y) - currentMap.height / 2
		let tempLayer = image
		addSubview(image)
		tempLayer.isOpaque = true
		tempLayer.backgroundColor = UIColor.clear
		tempLayer.frame = CGRect(x: startX, y: startY, width: currentMap.width, height: currentMap.height)
	}
}
