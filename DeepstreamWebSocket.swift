import Dispatch
import Foundation
import Starscream

/// The class that handles the transports.
class DeepstreamWebSocket : Endpoint {
    
    // MARK: Properties
    
    private static let logType = "DeepstreamWebSocket"
    
    /// The queue that all engine actions take place on.
    public let queue = DispatchQueue(label: "com.DeepstreamWebSocketQueue")
    
    /// `true` if this engine is closed.
    public private(set) var closed = false
    
    /// If `true` the engine will attempt to use WebSocket compression.
    public private(set) var compress = false
    
    /// `true` if this engine is connected. Connected means that the initial poll connect has succeeded.
    public private(set) var connected = false
    
    /// The WebSocket for this engine.
    public private(set) var webSocket: WebSocket?
    
    private final var connection: Connection?
    
    private let url: URL
    /// If `true` the engine will attempt to use WebSocket compression.

    
    private var security: DSSSLSecurity?
    private var selfSigned = false
    
    // MARK: Initializers
    
    /// Creates a new engine.
    ///
    /// - parameter client: The client for this engine.`
    /// - parameter url: The url for this engine.
    /// - parameter config: An array of configuration options for this engine.
    public init(url: URL, connection: Connection) {
        self.connection = connection
        self.url = url
    }
    
    public func send(_ message: String) {
        self.webSocket?.write(string: message)
    }
    
    public func close() {
        self.webSocket?.disconnect(forceTimeout: nil, closeCode: 1)
        self.webSocket = nil
    }
    
    public func forceClose() {
        self.webSocket?.disconnect(forceTimeout: nil, closeCode: 1)
        self.webSocket = nil
    }
    
    public func open() {
        self.webSocket = WebSocket(url: self.url)
        self.webSocket?.callbackQueue = queue
        self.webSocket?.enableCompression = compress
        if let scheme = self.url.scheme, scheme == "wss" {
            self.webSocket?.security = self.security?.security
        }
        
        self.webSocket?.connect()
    }
    
    //TODO: SSL AND DEFAULT CONFIG
    
}

extension DeepstreamWebSocket: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        self.connection?.onConnect()
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        if let error = error {
            self.connection?.onError(Error: error)
        }
        self.connection?.onDisconnect()
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        self.connection?.onMessage(Message: text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        self.connection?.onReceiveData(Data: data)
    }
    
}
