
import Foundation

/**
 * The interface required for any connection endpoints. Currently we support websockets
 */
@objc public protocol Endpoint{
    /**
     * Message to send to the deepstream server
     * @param message The message to send (TOPIC|ACTION|ARRAY+)
     */
    
    func send(_ msg: String);
    
    /**
     * Close the connection
     */
    func close();
    
    /**
     * Open the connection
     */
    func open();
    
    /**
     * Forces the connection to be closed
     */
    func forceClose();
    
}
