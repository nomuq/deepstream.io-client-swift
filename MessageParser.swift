
/**
 * Parses ASCII control character seperated
 * message strings into {@link Message}
 */
class MessageParser {
    
    let messageUnitSeparator: String = "\u{1F}"
    let messageRecordSeparator: String = "\u{1E}"
        
    /**
     * Main interface method. Receives a raw message
     * string, containing one or more messages
     * and returns an array of parsed message objects
     * or null for invalid messages
     */
    public static func parse(Message message: String) -> Message? {
        for item in message.components(separatedBy: messageRecordSeparator) {
            var array: [String] = item.components(separatedBy: messageUnitSeparator)
            
            if item.count == 0 || item == "" || array.count < 2 {
                //TODO: Throw Error 
                //client.onError( null, Event.MESSAGE_PARSE_ERROR, "Insufficient message parts" );
                return nil
            }
            
            guard let topic: Topic = Topic(rawValue: array[0]) else {
                //TODO: Throw Error
                //client.onError( null, Event.MESSAGE_PARSE_ERROR, "Received message for unknown topic " + parts[ 0 ] );
                return nil
            }
            
            guard let action: Actions = Actions(rawValue: array[1]) else {
                //TODO: Throw Error
                //client.onError( null, Event.MESSAGE_PARSE_ERROR, "Unknown action " + parts[ 1 ] );
                return nil
            }
            
            array.remove(at: 0)
            array.remove(at: 0)
            
            return Message(topic: topic, action: action, data: array, raw: nil)
            
        }
        
        return nil
        
    }
    
    
}

//TODO
///**
// * Deserializes values created by {@link MessageBuilder#typed(Object)} to
// * their original format
// *
// * @param value The value to deserialise
// * @param client The deepstream client to notify if errors occur
// * @return The object the value represented
// */
//static Object convertTyped( String value, DeepstreamClientAbstract client, Gson gson ) {
//
//    char type = value.charAt(0);
//
//    if( Types.getType( type ) == Types.STRING ) {
//        return value.substring( 1 );
//    }
//    else if( Types.getType( type ) == Types.NULL ) {
//        return null;
//    }
//    else if( Types.getType( type ) == Types.NUMBER ) {
//        return Float.parseFloat( value.substring( 1 ) );
//    }
//    else if( Types.getType( type ) == Types.TRUE ) {
//        return true;
//    }
//    else if( Types.getType( type ) == Types.FALSE ) {
//        return false;
//    }
//    else if( Types.getType( type ) == Types.OBJECT ) {
//        return parseObject( value.substring( 1 ), gson );
//    }
//    else if( Types.getType( type ) == Types.UNDEFINED ) {
//        return Types.UNDEFINED;
//    }
//
//    client.onError( Topic.ERROR, Event.MESSAGE_PARSE_ERROR, "UNKNOWN_TYPE (" + value + ")" );
//    return null;
//}
//
///**
// * parses the given object
// * @param value the value to parse
// * @param gson the gson instance to use
// * @return the parsed object
// */
//static Object parseObject(String value, Gson gson) {
//    return gson.fromJson( value, JsonElement.class );
//}
//
///**
// * reads a string as a json stream
// *
// * @param data the data to read
// * @param gson the gson instance to use
// * @return the parsed json element
// */
//static JsonElement readJsonStream(String data, Gson gson) {
//    JsonReader r = null;
//    JsonElement result = null;
//    try {
//    Reader reader = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(data.getBytes("UTF-8"))));
//    r = new JsonReader(reader);
//    result = gson.fromJson(r, JsonElement.class);
//    } catch (UnsupportedEncodingException e) {
//    e.printStackTrace();
//    } finally {
//        if (null != r) {
//            try {
//            r.close();
//            } catch (IOException e) {
//            e.printStackTrace();
//            }
//        }
//    }
//    return result;
//}



