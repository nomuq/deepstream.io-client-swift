
enum Types: String, Codable {
    /**
     * A string representation.
     * Example: SDog -> "Dog"
     */
    case STRING = "S"
    /**
     * A JsonElement representation.
     * Example: O{"type":"Dog"} -> JsonElement
     */
    case OBJECT = "O"
    /**
     * A number representation.
     * Example: N15-> 15
     */
    case NUMBER = "N"
    /**
     * Null representation
     * Example: L -> null
     */
    case NULL = "L"
    /**
     * Boolean true representation
     * Example: T -> true
     */
    case TRUE = "T"
    /**
     * Boolean False representation
     * Example: F -> false
     */
    case FALSE = "F"
    /**
     * Undefined representation
     * Example: U -> ...does not exist in java..
     */
    case UNDEFINED = "U"
    
}
