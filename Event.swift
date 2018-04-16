

/**
 * Provides all the different events that may occur. Most are related to errors for finer debugging and logging
 */
public enum Event{
    /**
     * To indicate a connection has not been authenticated longer than expected
     */
    case UNAUTHENTICATED_CONNECTION_TIMEOUT
    /**
     * To indicate a connection error was encountered
     */
    case CONNECTION_ERROR
    /**
     * To indicate the connection state was changed
     */
    case CONNECTION_STATE_CHANGED
    /**
     * To indicate an subscription ack has timed out
     */
    case ACK_TIMEOUT
    /**
     * Indicates the credentials provided were incorrect
     */
    case INVALID_AUTH_DATA
    /**
     * To indicate a record read from deepstream has timed out
     */
    case RESPONSE_TIMEOUT
    /**
     * To indicate a record read from deepstream has timed out while attempting to read from cache
     */
    case CACHE_RETRIEVAL_TIMEOUT
    /**
     * To indicate a record read from deepstream has timed out while attempting to read from storage
     */
    case STORAGE_RETRIEVAL_TIMEOUT
    /**
     * To indicate a record delete timed out
     */
    case DELETE_TIMEOUT
    /**
     * To indicate the client has received a message that it didn't expect
     */
    case UNSOLICITED_MESSAGE
    /**
     * To indicate the client has received a message that can't be parsed
     */
    case MESSAGE_PARSE_ERROR
    /**
     * To indicate the client has received a record update that conflicts with the one
     * in cache
     */
    case VERSION_EXISTS
    /**
     * To indicate the client has attempted to perform an operation before authenticating
     */
    case NOT_AUTHENTICATED
    /**
     * To indicate the client has attempted to add a listen pattern twice
     */
    case LISTENER_EXISTS
    /**
     * To indicate the client has attempted to remove a pattern that doesn't exist
     */
    case NOT_LISTENING
    /**
     * To indicate the client has attempted to login with incorrect credentials too many times
     */
    case TOO_MANY_AUTH_ATTEMPTS
    /**
     * To indicate the client has attempted to perform an action a connection that has been closed
     */
    case IS_CLOSED
    /**
     * To indicate the client has attempted to get a snapshot of a record that doesn't exist
     */
    case RECORD_NOT_FOUND
    /**
     * To indicate the client has attempted to perform an action they are not permissioned too
     */
    case MESSAGE_DENIED
    /**
     * To indicate multi subscriptions
     */
    case MULTIPLE_SUBSCRIPTIONS
    
}

