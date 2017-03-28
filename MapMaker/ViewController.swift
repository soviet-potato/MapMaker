//
//  ViewController.swift
//  MapMaker
//
//  Created by Samuil Agranovich on 2/27/17.
//  Copyright © 2017 Samuil Agranovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var canvasView: CanvasView!
	
	@IBOutlet var tempCanvas: TempCanvasView!
	
	//these are important. don't change them.
	var lastPoint = CGPoint.zero
	var swiped = false
	
	//layers: 0 is background, 1 is landforms, 2 is political, 3 is icons (2 and 3 later)
	var editingLayer = 0
	
	//brush characteristics here
	
	//this detects when a touch happens and sets it as the starting point
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		swiped = false
		lastPoint = (touches.first?.location(in: self.view))!
	}
	
	//this detects when a touch moves and draws a line along the movement
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		swiped = true
		let currentPoint = touches.first?.location(in: self.view)
		drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint!)
		lastPoint = currentPoint!
	}
	
	//this detects when a touch ends, and either draws a point if the touch didn't move or just draws the rest of the way, then merges the temp lines with the base canvas - should merge with the proper layer, need to fix that
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		if !swiped {
			drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
		}
		
		UIGraphicsBeginImageContext(view.frame.size)
		
		let currentLayer = canvasView.layers[editingLayer]
		
		currentLayer.image?.draw(in: self.view.frame)
		
		tempCanvas.image?.draw(in: self.view.frame)
		
		currentLayer.image = cropViewToMapSize()
		
		UIGraphicsEndImageContext()
		
		tempCanvas.image = nil
	}
	
	
	//this is the function that actually draws the line. qualities of the line are set in here, as properties of context
	func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
		
		UIGraphicsBeginImageContext(self.view.frame.size)

		tempCanvas.image?.draw(in: self.view.frame)
		
		let context = UIGraphicsGetCurrentContext()
		
		context?.move(to: fromPoint)
		context?.addLine(to: toPoint)
		
		//this is where the line qualities are set
		context?.setLineCap(.round)
		context?.setLineWidth(10.0)
		
		context?.strokePath()
		
		tempCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
	}
	
	func cropViewToMapSize()->UIImage {
		let startX = CGFloat(canvasView.frame.width / 2) - CGFloat(canvasView.currentMap.width / 2)
		let startY = CGFloat(canvasView.frame.height / 2) - CGFloat(canvasView.currentMap.height / 2)
		let cropStart = CGPoint(x: startX, y: startY)
		let cropSize = CGSize(width: canvasView.currentMap.width, height: canvasView.currentMap.height)
		
		let cropBounds = CGRect(origin: cropStart, size: cropSize)

		return (UIGraphicsGetImageFromCurrentImageContext()?.crop(rect: cropBounds))!
	}

	
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.populateLayersFromMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIImage {
	func crop(rect: CGRect) -> UIImage {
		var rect = rect
		rect.origin.x *= self.scale
		rect.origin.y *= self.scale
		rect.size.width *= self.scale
		rect.size.height *= self.scale
		
		let imageRef = self.cgImage!.cropping(to: rect)
		let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
		return image
	}
}

