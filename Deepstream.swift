//
//  Deepstream.swift
//  DeepStreamDemo
//
//  Created by Satish on 23/03/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Dispatch
import Foundation
import Starscream

class Factory: NSObject, URLSessionDelegate {
    
    private var url: URL!
    // public var connection : Connection! = Connection()
    
    private var webSocket: WebSocket? {
        didSet {
            self.webSocket?.onConnect = {
                // set timer 1000
                debugPrint("Connected")
            }
            
            self.webSocket?.onDisconnect = { (_: NSError?) in
                // close connection
                debugPrint("close connection")
            }
            
            self.webSocket?.onText = { [weak self] (text: String) in
                if self == nil{
                    return
                }
                
                // parse message
                if let message : Message = parse(Message: text){
                    debugPrint(message)
                    
                    switch message.topic{
                    case .Connection:
                        self?.handleConnection(Message: message)
                        
                    case .Auth:
                        break
                    case .Error:
                        break
                    case .Event:
                        break
                    case .Record:
                        break
                    case .RPC:
                        break
                    case .Presence:
                        break
                    }
                }else{
                    debugPrint("Error")
                }
                
            }
            
            self.webSocket?.onData = { (data: Data) in
                debugPrint("Data", data)
            }
            
        }
    }
    
    public init(url: URL) {
        self.url = url
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
        self.webSocket = WebSocket(url: self.url)
        self.webSocket?.connect()
    }
    
    
    func handleConnection(Message message: Message){
        switch message.action {
            
            
        case .Ping:
            webSocket?.write(string: buildMessage(Topic: Topic.Connection, Action: Action.Pong, Data: []))
            break
            
        case .Ack:
            //TODO:
            debugPrint("ConnectionState_AwaitingAuthentication")
            
            break
            
        case .Challenge:
            webSocket?.write(string: buildMessage(Topic: Topic.Connection, Action: Action.ChallengeResponse, Data: [url.absoluteString]))
            break
            
        case .Rejection:
            close()
            break
            
        case .Redirect:
            break
            
            
        default:
            break
        }
    }
    
    
}
