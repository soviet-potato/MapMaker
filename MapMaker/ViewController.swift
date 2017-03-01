//
//  ViewController.swift
//  MapMaker
//
//  Created by Samuil Agranovich on 2/27/17.
//  Copyright © 2017 Samuil Agranovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mapCanvas: CanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapCanvas.drawMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

