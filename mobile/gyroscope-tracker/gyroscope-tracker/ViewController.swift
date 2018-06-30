//
//  ViewController.swift
//  gyroscope-tracker
//
//  Created by Augusto Boranga on 19/05/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    
    //1
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    //2
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        // 2
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                           "localhost" as CFString,
                                           80,
                                           &readStream,
                                           &writeStream)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func send(_ sender: Any) {
        print("send!")
    }
    
}

