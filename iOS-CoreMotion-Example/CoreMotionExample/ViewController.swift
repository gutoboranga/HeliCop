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
    let THRESHOLD = 0.01
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

    @IBAction func resetSensors(_ sender: Any) {
        setX(x: 0)
        setY(y: 0)
        setZ(z: 0)
    }
    
    func createMessage() -> String {
        var message = "{ "
        
        message += "\"x\": " + String(xPosition)
//        message += ", "
//
//        message += "\"y\": " + String(yPosition)
//        message += ", "
//
//        message += "\"z\": " + String(zPosition)
        message += " }"
//
        print(message)
        return message
    }
    
    func update() {
        if let data = motionManager.deviceMotion {
            var x = 0
            var y = 0
            var z = 0
            
//            var x = data.rotationRate.x
//            var y = data.rotationRate.y
//            var z = data.rotationRate.z
            
            if (abs(data.rotationRate.x) > THRESHOLD) {
                setX(x: self.xPosition + data.rotationRate.x)
                send(text: createMessage());
            }
//            createMessage()
        }
    }
    
    func setX(x: Double) {
        self.xPosition = x;
        xLabel.text = String(self.xPosition)
    }
    
    func setY(y: Double) {
        self.yPosition = y;
        yLabel.text = String(self.yPosition)
    }
    
    func setZ(z: Double) {
        self.yPosition = z;
        zLabel.text = String(self.zPosition)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
