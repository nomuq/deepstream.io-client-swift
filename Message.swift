
/**
 * Message is the internal representation of a message that is sent to received from a deepstream
 * server
 */

struct Message: Codable {
    /**
     * @param raw The raw data received
     * @param topic The message topic
     * @param action The message action
     * @param data The message data, as an array
     */
    var topic: Topic
    var action: Actions
    var data: [String]
    var raw: String?
}
