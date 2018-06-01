//
//  Postman.swift
//  CoreMotionExample
//
//  Created by Augusto Boranga on 30/05/18.
//  Copyright © 2018 Maxim Bilan. All rights reserved.
//

import Foundation

class Postman {
    
    let isLittleEndian = Int(OSHostByteOrder()) == OSLittleEndian
    let INETADDRESS_ANY = in_addr(s_addr: 0)
    var host: String = "localhost"
    var port: UInt16 = 4000
    var sockAddress: sockaddr_in
    var sockFd: Int32 = 0

    init() {
        let htons  = isLittleEndian ? _OSSwapInt16 : { $0 }
        
        sockAddress = sockaddr_in(
            sin_len:    __uint8_t(MemoryLayout<sockaddr_in>.size),
            sin_family: sa_family_t(AF_INET),
            sin_port:   htons(port),
            sin_addr:   in_addr(s_addr: 0),
            sin_zero:   ( 0, 0, 0, 0, 0, 0, 0, 0 )
        )
//        sockAddress = s
    }
    
    func connect() {
        self.sockFd = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)
    }

    func send() {
        guard sockFd >= 0  else {
            let errmsg = String(cString: strerror(errno))
            print("Error: Could not create socket. \(errmsg)")
            return
        }
        
        let outData = Array("C'est le iPhone".utf8)

        
        let sent = withUnsafePointer(to: &sockAddress) {
            let p = UnsafeRawPointer($0).bindMemory(to: sockaddr.self, capacity: 1)

            sendto(sockFd, outData, outData.count, 0, p, socklen_t(sockAddress.sin_len))
        }
        
        print("Sent? \(sent)")
//        if sent == -1 {
//            let errmsg = String(cString: strerror(errno))
//            print("sendto failed: \(errno) \(errmsg)")
//            return
//        }
        
//        print("Just sent \(sent) bytes as \(outData)")
    }
    
    func disconnect() {
        close(sockFd);
    }
}
