
import Foundation
/**
 * Provides all the different connection states a deepstream client can go through its lifetime
 */
@objc public enum ConnectionState: Int {
    /**
     * Connection is closed, usually due to closing the client or getting multiple authentication rejects
     * from server
     */
    case CLOSED
    /**
     * Client is attempting to connect to a server
     */
    case AWAITING_CONNECTION
    /**
     * Client has connected to a server and is now enquiring if it should open a normal connection or be redirect
     * to another server first
     */
    case CHALLENGING
    /**
     * Client is waiting for user to login in order to authenticate connection with server
     */
    case AWAITING_AUTHENTICATION
    /**
     * Client has sent authentication to server and is waiting for a response
     */
    case AUTHENTICATING
    /**
     * Client connection is up and running
     */
    case OPEN
    /**
     * An error has occured on the connection, usually due to an recoverable connection drop or if no
     * server exists to connect to
     */
    case ERROR
    /**
     * Client is attempting to reconnect due to connection drop
     */
    case RECONNECTING 
}
