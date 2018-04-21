

public class Logger {
    
    // MARK: Properties
    static var instance: Logger = Logger()
    
    /// Whether to log or not
    var log: Bool = false
    
    /// log something generally unimportant (lowest priority)
    func verbose(_ message: @autoclosure () -> String, type: String) {
        abstractLog("VERBOSE", message: message, type: type)
    }
    
    /// log something which help during debugging (low priority)
    func debug(_ message: @autoclosure () -> String, type: String) {
        abstractLog("DEBUG", message: message, type: type)
    }
    
    /// log something which you are really interested but which is not an issue or error (normal priority)
    func info(_ message: @autoclosure () -> String, type: String) {
        abstractLog("INFO", message: message, type: type)
    }
    
    /// log something which may cause big trouble soon (high priority)
    func warn(_ message: @autoclosure () -> String, type: String) {
        abstractLog("WARNING", message: message, type: type)
    }
    
    /// log something which will keep you awake at night (highest priority)
    func error(_ message: @autoclosure () -> String, type: String) {
        abstractLog("ERROR", message: message, type: type)
    }
    
    func log(_ message: @autoclosure () -> String, type: String) {
        abstractLog("LOG", message: message, type: type)
    }
    
    private func abstractLog(_ logType: String, message: @autoclosure () -> String, type: String) {
        guard log else { return }
        print("\(logType) \(type): %@", message())
    }
}
