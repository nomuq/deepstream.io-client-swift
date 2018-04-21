
/**
 * A result of a login, indicating if it was successful or not and
 * associated data.
 */
public struct LoginResult {

    private var isLoggedIn: Bool
    private var errorEvent: Event?
    private var data: Any

}
