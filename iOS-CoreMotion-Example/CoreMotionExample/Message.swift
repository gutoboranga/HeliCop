//
//  MessageHandler.swift
//  CoreMotionExample
//
//  Created by Augusto Boranga on 30/05/18.
//  Copyright © 2018 Maxim Bilan. All rights reserved.
//

import Foundation

class Message {
    
    var x: Double
    var y: Double
    var z: Double
    
    init(_x: Double, _y: Double, _z: Double) {
        self.x = _x
        self.y = _y
        self.z = _z
    }
}

class Postman2 {
    
    var outputStream: OutputStream!
    var inputStream: InputStream!
    
    var host: String = "localhost"
    var port: UInt32 = 4000
    
    init(_host: String, _port: UInt32) {
        self.host = _host
        self.port = _port
    }
    
    func setupNetworkCommunication() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                           host as CFString,
                                           port,
                                           &readStream,
                                           &writeStream)
        
        self.inputStream = readStream!.takeRetainedValue()
        self.outputStream = writeStream!.takeRetainedValue()
        
        self.inputStream.schedule(in: .current, forMode: .commonModes)
        self.outputStream.schedule(in: .current, forMode: .commonModes)
        
        self.inputStream.open()
        self.outputStream.open()
    }
    
    func send(string: String) {
//        let data = string.data(using: String.Encoding.utf8)!
        
        
        let data = "C'est le iPhone".data(using: .utf8)!
        _ = data.withUnsafeBytes {bytes in
            self.outputStream.write(bytes, maxLength: data.count)
        }

//        self.outputStream.write(pointer, maxLength: data.length)
    }
}
