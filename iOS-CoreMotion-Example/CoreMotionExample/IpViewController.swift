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

class IpViewController: UIViewController {
   
    let port = 4000;
    var client: UDPClient?
    
    let MOBILE_TO_SIMULATOR_CONNECT = 0
    let SIMULATOR_TO_MOBILE_CONNECTED = 1
    let SIMULATOR_TO_MOBILE_ERROR = 2
    
    @IBOutlet weak var ipTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = UIColor(red: 127.0, green: 127.0, blue: 127.0, alpha: 1.0)
        
        self.ipTextField.layer.borderColor = color.cgColor
        self.ipTextField.layer.borderWidth = 1.0
        self.ipTextField.attributedPlaceholder = NSAttributedString(string: "Endereço IP",
                                                               attributes: [NSAttributedStringKey.foregroundColor: color])
    }
    
    @IBAction func connect(_ sender: Any) {
        
        client = UDPClient(address: self.ipTextField.text!, port: Int32(port))
        
        // envia um pedido de conexão
        _ = client?.send(string: String(MOBILE_TO_SIMULATOR_CONNECT))
        
        // recebe resposta
        if let data = client?.recv(1024) {
            if let bytes = data.0 {
                let string = String(bytes: bytes, encoding: .utf8)
                let response_code = Int(string!)

                // se a resposta foi positiva
                if response_code == SIMULATOR_TO_MOBILE_CONNECTED {
                    performSegue(withIdentifier: "ipConnectedSegue", sender: nil)
                } else {
                    showErrorMessage(message: "Ocorreu um erro ao conectar com o ip fornecido. Por favor, tente novamente.")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ipConnectedSegue" {
            let destinationVC = segue.destination as! OkViewController
            destinationVC.client = self.client
        }
    }
    
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
