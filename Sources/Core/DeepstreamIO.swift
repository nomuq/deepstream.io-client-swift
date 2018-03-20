//
//  DeepstreamIO.swift
//  DeepstreamIO
//
//  Created by Satish Babariya on 02/10/17.
//  Copyright © 2017 satishbabariya. All rights reserved.
//


import Foundation
import Starscream

final class WebsocketClient : NSObject {
    
    private var url : URL!
    //public var connection : Connection! = Connection()
    
    private var webSocket : WebSocket? {
        didSet {
            self.webSocket?.onConnect = {
                //set timer 1000
                debugPrint("Connected")
            }
            
            self.webSocket?.onDisconnect = { (error: NSError?) in
                //close connection
                debugPrint("close connection")
            }
            
            self.webSocket?.onText = { (text: String) in
                //parse message
                debugPrint("Text",text)
            }
            
            self.webSocket?.onData = { (data: Data) in
                debugPrint("Data",data)
            }
            
        }
    }
    
    public init(url: URL, connection: Connection) {
        self.url = url
        //self.connection = connection
    }
    
    public func send(_ message: String!) {
        self.webSocket?.write(string: message)
    }
    
    public func close() {
        self.webSocket?.disconnect()
        self.webSocket = nil
    }
    
    public func forceClose() {
        self.webSocket?.disconnect(forceTimeout: nil, closeCode: 1)
    }
    
    public func open() {
        self.webSocket = WebSocket(url: url)
        self.webSocket?.connect()
    }
    
}
