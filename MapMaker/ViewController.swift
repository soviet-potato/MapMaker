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
	var editingLayer = 1
	
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
		
		let width = canvasView.currentMap.width
		let height = canvasView.currentMap.height
		let startX = Int(canvasView.center.x) - width / 2
		let startY = Int(canvasView.center.y) - height / 2
		
		currentLayer.draw(CGRect(x: startX, y: startY, width: width, height: height))
		
		tempCanvas.image?.draw(in: CGRect(x: startX, y: startY, width: width, height: height))
		
		currentLayer.image = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
		
		tempCanvas.image = nil
	}
	
	
	//this is the function that actually draws the line. qualities of the line are set in here, as properties of context
	func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
		UIGraphicsBeginImageContext(view.frame.size)
		let width = canvasView.currentMap.width
		let height = canvasView.currentMap.height
		let startX = Int(canvasView.center.x) - width / 2
		let startY = Int(canvasView.center.y) - height / 2

		tempCanvas.image?.draw(in: CGRect(x: startX, y: startY, width: width, height: height))
		
		let context = UIGraphicsGetCurrentContext()
		
		context?.move(to: fromPoint)
		context?.addLine(to: toPoint)
		
		//this is where the line qualities are set
		context?.setLineCap(.round)
		context?.setLineWidth(10.0)
		
		context?.strokePath()
		
		tempCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
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

