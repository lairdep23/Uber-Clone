//
//  ViewController.swift
//  ZoomMe
//
//  Created by Evan on 6/17/17.
//  Copyright © 2017 Evan Laird. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rideRequestBtn: RoundShadowButton!
    
    var delegate: CenterVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rideRequestPressed(_ sender: Any) {
        rideRequestBtn.animateButton(shouldLoad: true, withMessage: "")
    }
    @IBAction func menuBtnPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
        
    }

}

