

// TODO: Check if this works

/// The options for a client.
public enum ConfigOptions {
    
    /**
     * Default path to use when connection using websockets
     * Defaults to /deepstream
     */
    case PATH
    /**
     * Specifies the number of milliseconds by which the time until the next reconnection attempt will be incremented
     * after every unsuccessful attempt.
     * E.g.for 1500: if the connection is lost,the client will attempt to reconnect immediately, if that fails it will
     * try again after 1.5 seconds, if that fails it will try again after 3 seconds and so on...
     */
    case RECONNECT_INTERVAL_INCREMENT
    /**
     * The maximum amount of time that can pass before a reconnect is attempted. This supersedes the
     * multiplying factor provided by RECONNECT_INTERVAL_INCREMENT
     */
    case MAX_RECONNECT_INTERVAL
    /**
     * The number of reconnection attempts until the client gives up and declares the connection closed.
     */
    case MAX_RECONNECT_ATTEMPTS
    /**
     * The number of milliseconds after which a RPC will error if no Ack-message has been received.
     */
    case RPC_ACK_TIMEOUT
    /**
     * The number of milliseconds after which a RPC will error if no response-message has been received.
     */
    case RPC_RESPONSE_TIMEOUT
    /**
     * The number of milliseconds that can pass after providing/unproviding a RPC or subscribing/unsubscribing/listening
     * to a record or event before an error is thrown.
     */
    case SUBSCRIPTION_TIMEOUT
    /**
     * If your app sends a large number of messages in quick succession, the deepstream client will try to split them
     * into smaller packets and send these every ms. This parameter specifies the number of messages after which
     * deepstream sends the packet and queues the remaining messages.
     */
    case MAX_MESSAGES_PER_PACKET
    /**
     * Please see description for maxMessagesPerPacket. Sets the time in ms.
     */
    case TIME_BETWEEN_SENDING_QUEUED_PACKAGES
    /**
     * The number of milliseconds from the moment client.record.getRecord() is called until an error is thrown since no
     * ack message has been received.
     */
    case RECORD_READ_ACK_TIMEOUT
    /**
     * The number of milliseconds from the moment client.record.getRecord() is called until an error is thrown since no
     * data has been received.
     */
    case RECORD_READ_TIMEOUT
    /**
     * The number of milliseconds from the moment record.delete() is called until an error is thrown since no delete ack
     * message has been received. Please take into account that the deletion is only complete after the record has been deleted from both cache and storage.
     */
    case RECORD_DELETE_TIMEOUT
    
    /**
     * The merge strategy
     */
    case RECORD_MERGE_STRATEGY
    
    /// If passed `true`, the client will log debug information. This should be turned off in production code.
    case log(Bool)
    
    // MARK: Properties
    
    /// The description of this option.
    public var description: String {
        
        switch self {
        case .PATH:
            return "path"
        case .RECONNECT_INTERVAL_INCREMENT:
            return "reconnectIntervalIncrement"
        case .MAX_RECONNECT_INTERVAL:
            return "maxReconnectInterval"
        case .MAX_RECONNECT_ATTEMPTS:
            return "maxReconnectAttempts"
        case .RPC_ACK_TIMEOUT:
            return "rpcAckTimeout"
        case .RPC_RESPONSE_TIMEOUT:
            return "rpcResponseTimeout"
        case .SUBSCRIPTION_TIMEOUT:
            return "subscriptionTimeout"
        case .MAX_MESSAGES_PER_PACKET:
            return "maxMessagesPerPacket"
        case .TIME_BETWEEN_SENDING_QUEUED_PACKAGES:
            return "timeBetweenSendingQueuedPackages"
        case .RECORD_READ_ACK_TIMEOUT:
            return "recordReadAckTimeout"
        case .RECORD_READ_TIMEOUT:
            return "recordReadTimeout"
        case .RECORD_DELETE_TIMEOUT:
            return "recordDeleteTimeout"
        case .RECORD_MERGE_STRATEGY:
            return "recordMergeStrategy"
        case .log:
            return "log"
        }
    }
    
    public func getConfigOptionsValue() -> Any {
        
        switch self {
            
        case .PATH:
            return "/deepstream"
        case .RECONNECT_INTERVAL_INCREMENT:
            return 4000
        case .MAX_RECONNECT_INTERVAL:
            return 1500
        case .MAX_RECONNECT_ATTEMPTS:
            return 5
        case .RPC_ACK_TIMEOUT:
            return 6000
        case .RPC_RESPONSE_TIMEOUT:
            return 10000
        case .SUBSCRIPTION_TIMEOUT:
            return 2000
        case .MAX_MESSAGES_PER_PACKET:
            return 100
        case .TIME_BETWEEN_SENDING_QUEUED_PACKAGES:
            return 16
        case .RECORD_READ_ACK_TIMEOUT:
            return 1000
        case .RECORD_READ_TIMEOUT:
            return 3000
        case .RECORD_DELETE_TIMEOUT:
            return 3000
        case .RECORD_MERGE_STRATEGY:
            return "REMOTE_WINS"
        case .log(let log):
            return log
        }
    }
    
    // MARK: Operators
    
    /// Compares whether two options are the same.
    ///
    /// - parameter lhs: Left operand to compare.
    /// - parameter rhs: Right operand to compare.
    /// - returns: `true` if the two are the same option.
    public static func ==(lhs: ConfigOptions, rhs: ConfigOptions) -> Bool {
        return lhs.description == rhs.description
    }
    
}
