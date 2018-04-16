
/**
 * Provides the different topics that deepstream connections use. A user of this sdk will only need to access these
 * during error messages, such as via the {@link DeepstreamException}
 */
public enum Topic : String,Codable{
    /**
     * Connection topic, related to the first exchanges with server to validate connection
     */
    case CONNECTION = "C"
    /**
     * Auth topic, related to the second exchange with server to authenticate
     * connection
     */
    case AUTH = "A"
    /**
     * All generic errors arrive on this topic
     */
    case ERROR = "X"
    /**
     * Event data is routed through this topic
     */
    case EVENT = "E"
    /**
     * Record data is routed through this topic
     */
    case RECORD = "R"
    /**
     * RPC data is routed through this topic
     */
    case RPC = "P"
    /**
     * Presence data is routed through this topic
     */
    case PRESENCE = "U"
    
}
