import Foundation

/**
 * Creates a deepstream message string, based on the
 * provided parameters
 */

class MessageBuilder {
    
    static let messageUnitSeparator: String = "\u{1F}"
    static let messageRecordSeparator: String = "\u{1E}"
    
    public static func getMsg(Topic topic: Topic, Actions actions: Actions, Name name: String, Data data: String) -> String {
        return topic.rawValue + messageUnitSeparator + actions.rawValue + messageUnitSeparator + name + messageUnitSeparator + data + messageRecordSeparator
    }
    
    public static func getMsg(Topic topic: Topic, Actions actions: Actions, Data data: String) -> String {
        return topic.rawValue + messageUnitSeparator + actions.rawValue + messageUnitSeparator + data + messageRecordSeparator
    }
    
    // TODO: Test this func for changes
    // return topic.toString() + MPS + action.toString() + MPS + join( data) + MS;
    public static func getMsg(Topic topic: Topic, Actions actions: Actions, Data data: [String]) -> String {
        var string: String = topic.rawValue + messageUnitSeparator + actions.rawValue
        for item in data {
            string = string + messageUnitSeparator + item
        }
        return string + messageRecordSeparator
    }
    
    public static func getMsg(Topic topic: Topic, Actions actions: Actions) -> String {
        return topic.rawValue + messageUnitSeparator + actions.rawValue + messageRecordSeparator
    }
    
    /**
     * Converts a serializable value into its string-representation and adds
     * a flag that provides instructions on how to deserialize it.
     * @param value The value to serialised
     * @return string representation of the value
     */
    public static func typed(Value value: Any) -> String {
        if let int: Int = value as? Int {
            return Types.NUMBER.rawValue + "\(int)"
        }
        
        if let str: String = value as? String {
            return Types.STRING.rawValue + str
        }
        
        if let bool: Bool = value as? Bool {
            if bool {
                return Types.TRUE.rawValue
            } else {
                return Types.FALSE.rawValue
            }
        }
        
        do {
            let json = try JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let str = String(data: json, encoding: String.Encoding.utf8) {
                return Types.OBJECT.rawValue + str
            } else {
                return Types.NULL.rawValue
            }
        } catch {
            //TODO: Throw Error
            //client.onError( null, Event.MESSAGE_PARSE_ERROR, "Unknown action " + parts[ 1 ] );
            return Types.NULL.rawValue
        }
        
    }
    
}
