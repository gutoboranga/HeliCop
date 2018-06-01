//
//  ViewController.swift
//  CoreMotionExample
//
//  Created by Maxim Bilan on 1/21/16.
//  Copyright © 2016 Maxim Bilan. All rights reserved.
//

import UIKit
import CoreMotion
import SwiftSocket

class ViewController: UIViewController {

    // Gyroscope stuff
    let THRESHOLD = 0.5
    let motionManager = CMMotionManager()
	var timer: Timer!
    
    var xPosition: Double = 0;
    var yPosition: Double = 0;
    var zPosition: Double = 0;
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
	
    // UPD connection stuff
    @IBOutlet weak var ipTextField: UITextField!
    
    let port = 4000
    var client: UDPClient?
    
    override func viewDidLoad() {
		super.viewDidLoad()
        
        self.connect(self)
	}
    
    override func viewDidAppear(_ animated: Bool) {
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
            self.update()
        }
    }
    
    @IBAction func connect(_ sender: Any) {
        client = UDPClient(address: self.ipTextField.text!, port: Int32(port))
    }
    
    func send(text: String) {
        _ = client?.send(string: text)
    }

    @IBAction func sendData(_ sender: Any) {
        send(text: createMessage());
    }
    
    func createMessage() -> String {
        let message = "{\"x\": \"" + String(xPosition) + "\"}"
        print(message)
        return message
//        {"name": "top_memes_generator","version": "1.0.0"}
    }
    
    func update() {
        if let data = motionManager.deviceMotion {
            var x = data.rotationRate.x
//            var y = data.rotationRate.y
//            var z = data.rotationRate.z
            
            if (abs(x) > THRESHOLD) {
                self.xPosition += x;
                xLabel.text = String(self.xPosition)
                
                send(text: createMessage());
                
            } else {
                x = 0
            }
            
//            if (abs(y) > THRESHOLD) {
//                self.yPosition += y;
//                yLabel.text = String(self.yPosition)
//            } else {
//                y = 0
//            }
//
//            if (abs(z) > THRESHOLD) {
//                self.zPosition += z;
//                zLabel.text = String(self.zPosition)
//            } else {
//                z = 0
//            }
            
//            print("x: ",x,"\ty: ",y,"\tz: ",z)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
