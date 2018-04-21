
public class DeepstreamClient{
    
    
 
    
}

enum LoginCallback {
    /**
     * Called when {@link DeepstreamClient#login(JsonElement)} is successful
     *
     * @param userData Optional data that is specific to the user and returned on succesfuly authentication
     */
    case loginSuccess(Any)
    /**
     * Called when {@link DeepstreamClient#login(JsonElement)} is unsuccessful
     *
     * @param errorEvent error event
     * @param data       Contains data associated to the failed login, such as the reason
     */
    case loginFailed(Event,Any)
}

