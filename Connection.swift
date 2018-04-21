

import Dispatch
import Foundation
import Starscream

/// The class that handles the transports.
public final class Connection {
    
    // MARK: Properties
    
    private static var logType = "Connection"
    
    /// The queue that all engine actions take place on.
    public var queue = DispatchQueue(label: "com.deepstream.ConnectionHandleQueue")
    
    /// The client.
    public weak var client: DeepstreamClient?
    
    private var options: DeepstreamConfig!
    
    private var endpoint: Endpoint!
    
    private var tooManyAuthAttempts: Bool = false
    
    private var challengeDenied: Bool = false
    
    private var deliberateClose: Bool = false
    
    private var redirecting: Bool = false
    
    private var reconnectTimeout: Timer?
    
    private var reconnectionAttempt: Int = 0
    
    private var url: URL
    
    private var connectionState: ConnectionState = ConnectionState.CLOSED
    
    private var globalConnectivityState: GlobalConnectivityState = GlobalConnectivityState.DISCONNECTED
    
    // private DeepstreamClient.LoginCallback loginCallback;
    
    private var authParameters: [String: String] = [:]
    
    private weak var connectStateListener: ConnectionStateListener?
    
    /**
     * Creates an endpoint and passed it to {@link Connection#Connection(String, DeepstreamConfig, DeepstreamClient, EndpointFactory, Endpoint)}
     *
     * @see Connection#Connection(String, DeepstreamConfig, DeepstreamClient, EndpointFactory, Endpoint)
     *
     * @param url The endpoint url
     * @param options The options used to initialise the deepstream client
     * @param endpointFactory The factory to create endpoints
     * @param client The deepstream client
     * @throws URISyntaxException An exception if an invalid url is passed in
     */
    
    public init(URL url: URL, Options options: DeepstreamConfig, Client client: DeepstreamClient, Endpoint endpoint: Endpoint?) {
        self.url = url
        self.options = options
        self.client = client
        if let endpoint = endpoint {
            self.endpoint = endpoint
        } else {
            self.createEndpoint()
        }
    }
    
    /**
     * Authenticate the user connection
     * @param authParameters The authentication parameters to send to deepstream
     * @param loginCallback The callback for a successful / unsuccessful login attempt
     * connection
     */
    
    func authenticate(authParameters: [String: String]?, completion: @escaping (LoginCallback) -> ()) {
        if let authParameters = authParameters {
            self.authParameters = authParameters
        }
        
        if self.tooManyAuthAttempts || self.challengeDenied {
            // TODO: HANDLE ERROR
            //this.client.onError( Topic.ERROR, Event.IS_CLOSED, "The client\'s connection was closed" );
            completion(LoginCallback.loginFailed(Event.IS_CLOSED, "The client's connection was closed"))
            return
        }
        
        if self.connectionState == ConnectionState.AWAITING_AUTHENTICATION {
            self.sendAuthMessage()
        }
        
    }
    
    private func sendAuthMessage() {
        self.setState(ConnectionState: ConnectionState.AUTHENTICATING)
        var authMessage: String = ""
        if self.authParameters != [:] {
            authMessage = MessageBuilder.getMsg(Topic: Topic.AUTH, Actions: Actions.REQUEST, Data: self.authParameters.dict2json())
        } else {
            authMessage = MessageBuilder.getMsg(Topic: Topic.AUTH, Actions: Actions.REQUEST)
        }
        self.send(message: authMessage)
    }
    
    private func setState(ConnectionState state: ConnectionState) {
        self.connectionState = state
        self.connectStateListener?.connectionStateChanged(state: state)
        if state == ConnectionState.AWAITING_AUTHENTICATION && self.authParameters != [:] {
            self.sendAuthMessage()
        }
    }
    

    func addConnectionChangeListener(ConnectionStateListener connectionStateListener : ConnectionStateListener) {
        self.connectStateListener = connectionStateListener
    }
        
    func removeConnectionChangeListener(ConnectionStateListener connectionStateListener : ConnectionStateListener) {
        self.connectStateListener = nil
    }
    
    public func send(message: String) {
        // TODO: Implement Message Buffer
        self.endpoint.send(message)
    }
    
    func sendMsg(Topic topic : Topic, Actions actions : Actions, Data data : [String]) {
        self.send(message: MessageBuilder.getMsg(Topic: topic, Actions: actions, Data: data))
    }
    
    func getConnectionState() -> ConnectionState {
        return self.connectionState
    }
    
    private func createEndpoint() {
        self.endpoint.open()
    }
    
    
    
    
    func onMessage(Message message: String) {
        if let parsedMessages = MessageParser.parse(Message: message) {
            switch parsedMessages.topic{
                
            case .CONNECTION:
                handleConnectionResponse(Message: parsedMessages)
                
            case .AUTH:
                //handleAuthResponse(message)
            case .ERROR:
            //TODO:
                //this.client.onError(Topic.ERROR, Event.UNSOLICITED_MESSAGE, message.action.toString());
            case .EVENT:
//                this.eventThread.execute(new Runnable() {
//                    @Override
//                    public void run() {
//                        client.event.handle(message);
//                    }
//                });
            case .RECORD:
//                this.recordThread.execute(new Runnable() {
//                    @Override
//                    public void run() {
//                        client.record.handle(message);
//                    }
//                });
            case .RPC:
//                this.rpcThread.execute(new Runnable() {
//                    @Override
//                    public void run() {
//                        client.rpc.handle(message);
//                    }
//                });
            case .PRESENCE:
//                this.presenceThread.execute(new Runnable() {
//                    @Override
//                    public void run() {
//                        client.presence.handle( message );
//                    }
//                });
            }
        }
    }
    
    func close() {
        self.deliberateClose = true
        if endpoint != nil{
            endpoint.close()
            endpoint = nil
        }
        if reconnectTimeout != nil{
            reconnectTimeout?.invalidate()
            reconnectTimeout = nil
        }
        self.queue.suspend()
        
    }
    
    func onConnect() {
        self.setState(ConnectionState: ConnectionState.AWAITING_AUTHENTICATION)
    }
    
    func onDisconnect() {
        if self.redirecting{
            self.redirecting = false
            self.createEndpoint()
        }else if  self.deliberateClose{
            self.setState(ConnectionState: ConnectionState.CLOSED)
        }else {
            self.tryReconnect()
        }
    }
    
    
    func handleConnectionResponse(Message message : Message){
        switch message.action {
        case .PING:
            self.endpoint.send(MessageBuilder.getMsg(Topic: Topic.CONNECTION, Actions: Actions.PONG))
        case .ACK:
            self.setState(ConnectionState: ConnectionState.AWAITING_AUTHENTICATION)
        case .CHALLENGE:
            self.setState(ConnectionState: ConnectionState.CHALLENGING)
            self.endpoint.send(MessageBuilder.getMsg(Topic: Topic.CONNECTION, Actions: Actions.CHALLENGE_RESPONSE, Data: self.url.absoluteString))
        case .REJECTION:
            self.challengeDenied = true
            self.close()
        case .REDIRECT:
            if let url : String = message.data.first, url != ""{
                self.url = URL(string: url)!
                self.redirecting = true
                self.endpoint.close()
                self.endpoint = nil
            }
        default:
            break
        }
    }
    
    func handleAuthResponse(Message message : Message){
        switch message.action {
        case .ACK:
            self.setState(ConnectionState: ConnectionState.OPEN)
            //TODO: Send stored buffered messages
//            if( this.loginCallback != null ) {
//                try {
//                Object data = MessageParser.convertTyped(message.data[0], this.client, this.options.getJsonParser());
//                this.loginCallback.loginSuccess(data);
//                } catch (IndexOutOfBoundsException e) {
//                this.loginCallback.loginSuccess(null);
//                }
//            }
        case .ERROR:
            if let first : String = message.data.first , first == "TOO_MANY_AUTH_ATTEMPTS"{
                self.deliberateClose = true
                self.tooManyAuthAttempts = true
            }else{
                self.authParameters = [:]
                self.setState(ConnectionState: ConnectionState.AWAITING_AUTHENTICATION)
            }
            //TODO:
//            if( this.loginCallback != null ) {
//                this.loginCallback.loginFailed(
//                    Event.getEvent( message.data[ 0 ] ),
//                    MessageParser.convertTyped(message.data[1], this.client, this.options.getJsonParser())
//                );
//            }
        default:
            break
        }
    }
    
    
    
    func onReceiveData(Data data: Data) {
        
    }
    
    func onError(Error error: Error) {
        setState(ConnectionState: ConnectionState.ERROR)
        /*
         * If the implementation isn't listening on the error event this will throw
         * an error. So let's defer it to allow the reconnection to kick in.
         */
        Timer.scheduledTimer(withTimeInterval: 1000, repeats: true) { (timer) in
            //TODO: Add this in client event and throw error
            //client.onError( null, Event.CONNECTION_ERROR, error);
        }
    }
    
    func tryOpen()  {
        self.reconnectTimeout?.invalidate()
        self.reconnectTimeout = nil
        self.endpoint.open()
    }
    
    func clearReconnect()  {
        self.reconnectTimeout = nil
        self.reconnectionAttempt = 0
    }

    
    
    func tryReconnect(){
        if self.reconnectTimeout != nil{
            return
        }
        
        
    }
    
    /**
     * Set global connectivity state.
     * @param  {GlobalConnectivityState} globalConnectivityState Current global connectivity state
     */
    func setGlobalConnectivityState(GlobalConnectivityState state : GlobalConnectivityState) {
        self.globalConnectivityState = state
        if state == GlobalConnectivityState.CONNECTED{
            if self.connectionState == .CLOSED || self.connectionState == .ERROR{
                tryReconnect()
            }
        }else {
            if self.reconnectTimeout != nil{
                self.reconnectTimeout?.invalidate()
            }
            self.reconnectTimeout = nil
            self.reconnectionAttempt = 0
            self.endpoint.forceClose()
            self.setState(ConnectionState: ConnectionState.CLOSED)
        }
    }
    
    /**
     * Take the url passed when creating the client and ensure the correct
     * protocol is provided
     * @param  {String} url Url passed in by client
     * @param  {String} defaultPath Default path to concatenate if one doest not exist
     * @return {String} Url with supported protocol
     */
    func parseUrl(URL url : URL, DefaultURL default : URL)  {
        if url.scheme == "http" || url.scheme == "https"{
            //TODO: Throw Error
            //"HTTP/HTTPS is not supported, please use ws or wss instead"
        }
    }
    
}


private void tryReconnect() {
    if( this.reconnectTimeout != null ) {
        return;
    }
    
    int maxReconnectAttempts = options.getMaxReconnectAttempts();
    int reconnectIntervalIncrement = options.getReconnectIntervalIncrement();
    int maxReconnectInterval = options.getMaxReconnectInterval();
    
    if( this.reconnectionAttempt < maxReconnectAttempts ) {
        if(this.globalConnectivityState == GlobalConnectivityState.CONNECTED) {
            this.setState(ConnectionState.RECONNECTING);
            this.reconnectTimeout = new Timer();
            this.reconnectTimeout.schedule(new TimerTask() {
                public void run() {
                    tryOpen();
                }
                }, Math.min(
                    reconnectIntervalIncrement * this.reconnectionAttempt,
                    maxReconnectInterval
            ));
            this.reconnectionAttempt++;
        }
        
    } else {
        this.clearReconnect();
        this.close(true);
    }
}














