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
	
	var lastPoint = CGPoint.zero
	var swiped = false
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		swiped = false
		lastPoint = (touches.first?.location(in: self.view))!
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		swiped = true
		let currentPoint = touches.first?.location(in: self.view)
		drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint!)
		lastPoint = currentPoint!
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		if !swiped {
			drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
		}
		
		UIGraphicsBeginImageContext(view.frame.size)
		
		canvasView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
		
		tempCanvas.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
		
		canvasView.image = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
		
		tempCanvas.image = nil
	}
	
	func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
		UIGraphicsBeginImageContext(view.frame.size)
		tempCanvas.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
		
		let context = UIGraphicsGetCurrentContext()
		
		context?.move(to: fromPoint)
		context?.addLine(to: toPoint)
		
		context?.setLineCap(.round)
		context?.setLineWidth(10.0)
		
		context?.strokePath()
		
		tempCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
	}

	
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.drawMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

