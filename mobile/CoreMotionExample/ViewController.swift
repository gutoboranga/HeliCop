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
    let THRESHOLD = 0.02
    let THRESHOLD_X = 0.02
    let MAX_ANGLE = 18
    
    let motionManager = CMMotionManager()
//    let altimeter = CMAltimeter()
//    var timer: Timer!
    
    var up: Bool = false;
    
    var xPosition: Double = 0;
    var yPosition: Double = 0;
    var zPosition: Double = 0;
    
    @IBOutlet weak var upButton: UIButton!
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    @IBOutlet weak var ipTextField: UITextField!
    
    let port = 4000
    var client: UDPClient?
    
    override func viewDidLoad() {
		super.viewDidLoad()
        
        upButton.addTarget(self, action: #selector(buttonDown), for: .touchDown)
        upButton.addTarget(self, action: #selector(buttonUp), for: [.touchUpInside, .touchUpOutside])
	}
    
    override func viewDidAppear(_ animated: Bool) {
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
            self.update()
        }
        
//        altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!) { (data, error) in
//            if let altitudeData = data {
//                let relativeAltitude = altitudeData.relativeAltitude
//
//                print(relativeAltitude)
//            }
//        }
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
        message += ", "

        message += "\"y\": " + String(yPosition)
        message += ", "

        message += "\"z\": " + String(zPosition)
        message += ", "
        
        message += "\"up\": " + "\"" + mapBoolToString(b: up) + "\""
        message += " }"

        return message
    }
    
    func update() {
        if let data = motionManager.deviceMotion {

//            send(text: createMessage())
            var moved = false

            if (abs(data.rotationRate.x) > THRESHOLD_X) {
                setX(x: (self.xPosition + data.rotationRate.x))
                moved = true
            }

            if (abs(data.rotationRate.y) > THRESHOLD) {
                setY(y: (self.yPosition + data.rotationRate.y))
                moved = true
            }

            if (abs(data.rotationRate.z) > THRESHOLD) {
                setZ(z: (self.zPosition + data.rotationRate.z))
                moved = true
            }
            
            // se botão para acelerar para cima estiver pressionado
            if (up) {
                moved = true
            }

            // se moveu em algum eixo, envia msg pro socket
            if (moved) {
                let message = createMessage()
                send(text: message)
                
                print(message)
            }
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
        self.zPosition = z;
        zLabel.text = String(self.zPosition)
    }
    
    @objc func buttonDown(_ sender: UIButton) {
        up = true
        print("True")
    }
    
    @objc func buttonUp(_ sender: UIButton) {
        up = false
        print("False")
    }
    
    func mapBoolToString(b: Bool) -> String {
        if (b) {
            return "True"
        }
        return "False"
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
