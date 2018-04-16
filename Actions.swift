

enum Actions: String, Codable {
    /**
     * Error action to indicate something on the server did not go as expected
     */
    case ERROR = "E"
    /**
     * A heartbeat ping from server
     */
    case PING =  "PI"
    /**
     * An heartbeat pong to server
     */
    case PONG =  "PO"
    /**
     * An acknowledgement from server
     */
    case ACK =  "A"
    /**
     * A connection redirect to allow client to connect to other deepstream
     * for load balancing
     */
    case REDIRECT =  "RED"
    /**
     * A connection challenge
     */
    case CHALLENGE =  "CH"
    /**
     * Connection challenge response
     */
    case CHALLENGE_RESPONSE =  "CHR"
    /**
     * A request or response containing record data for a snapshot or subscription
     */
    case READ =  "R"
    /**
     * A create to indicate record can be created if it doesn't exist
     */
    case CREATE =  "C"
    /**
     * A combination of both the create and read actions
     */
    case CREATEORREAD = "CR"
    /*
     * An upsert operation so that clients can set record data
     * without being subscribed to the record
     */
    case CREATEANDUPDATE = "CU"
    /**
     * An update, meaning all data in record has been updated
     */
    case UPDATE =  "U"
    /**
     * A path, meaning a specific part of data under a path has been
     * updated
     */
    case PATCH =  "P"
    /**
     * Delete a record / be informed a record has been deleted
     */
    case DELETE =  "D"
    /**
     * Used to subscribe to most things, including events, records
     * ( although records use CR ) and providing rpcs
     */
    case SUBSCRIBE =  "S"
    /**
     * Used to unsubscribe to anything that was previously subscribed to
     */
    case UNSUBSCRIBE =  "US"
    /**
     * Action to enquire if record actually exists on deepstream
     */
    case HAS =  "H"
    /**
     * Ask for the current state of a record
     */
    case SNAPSHOT =  "SN"
    /**
     * Used to inform the client listener that it has the opportunity to provide the data
     * for a event or record subscription
     */
    case SUBSCRIPTION_FOR_PATTERN_FOUND =  "SP"
    /**
     * Used to inform listener that it it is no longer required to provide the data for a
     * event or record subscription
     */
    case SUBSCRIPTION_FOR_PATTERN_REMOVED =  "SR"
    /**
     * Used to indicate if a record has a provider currently providing it data
     */
    case SUBSCRIPTION_HAS_PROVIDER = "SH"
    /**
     * Inform the server that it the client is willing to provide any subscription matching
     * a pattern
     */
    case LISTEN =  "L"
    /**
     * Inform the server that it the client is no longer willing to provide any subscription
     * matching a pattern
     */
    case UNLISTEN =  "UL"
    /**
     * Inform the server the provider is willing to provide the subscription
     */
    case LISTEN_ACCEPT = "LA"
    /**
     * Inform the server the provider is not willing to provide the subscription
     */
    case LISTEN_REJECT = "LR"
    /**
     * Inform the client a remote event has occured
     */
    case EVENT =  "EVT"
    /**
     * A request to the server, used for RPC, authentication and connection
     */
    case REQUEST =  "REQ"
    /**
     * A response from the server for a request
     */
    case RESPONSE =  "RES"
    /**
     * Used to reject RPC requests
     */
    case REJECTION =  "REJ"
    /**
     * Called when a user logs in
     */
    case PRESENCE_JOIN =  "PNJ"
    /**
     * Called when a user logs out
     */
    case PRESENCE_LEAVE =  "PNL"
    /**
     * Used to query for clients
     */
    case QUERY =  "Q"
    /**
     * Used when requiring write acknowledgements when setting records
     */
    case WRITE_ACKNOWLEDGEMENT =  "WA" 
}
