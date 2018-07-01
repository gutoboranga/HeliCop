//
//  IpViewController.swift
//  CoreMotionExample
//
//  Created by Augusto Boranga on 24/06/18.
//  Copyright © 2018 Maxim Bilan. All rights reserved.
//

import UIKit
import CoreMotion
import SwiftSocket

class OkViewController: UIViewController {
    
    var client: UDPClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OkController up and running")
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "okToSimulationSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "okToSimulationSegue" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.client = self.client
        }
    }
}
