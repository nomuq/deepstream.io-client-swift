

import Foundation
import Starscream

/// A wrapper around Starscream's SSLSecurity that provides a minimal Objective-C interface.
open class DSSSLSecurity : NSObject {
    // MARK: Properties
    
    /// The internal Starscream SSLSecurity.
    public let security: Starscream.SSLSecurity
    
    init(security: Starscream.SSLSecurity) {
        self.security = security
    }
    
    // MARK: Methods
    
    /// Creates a new SSLSecurity that specifies whether to use publicKeys or certificates should be used for SSL
    /// pinning validation
    ///
    /// - parameter usePublicKeys: is to specific if the publicKeys or certificates should be used for SSL pinning
    /// validation
    @objc
    public convenience init(usePublicKeys: Bool = true) {
        let security = Starscream.SSLSecurity(usePublicKeys: usePublicKeys)
        self.init(security: security)
    }
    
    
    /// Designated init
    ///
    /// - parameter certs: is the certificates or public keys to use
    /// - parameter usePublicKeys: is to specific if the publicKeys or certificates should be used for SSL pinning
    /// validation
    /// - returns: a representation security object to be used with
    public convenience init(certs: [SSLCert], usePublicKeys: Bool) {
        let security = Starscream.SSLSecurity(certs: certs, usePublicKeys: usePublicKeys)
        self.init(security: security)
    }
    
    /// Returns whether or not the given trust is valid.
    ///
    /// - parameter trust: The trust to validate.
    /// - parameter domain: The CN domain to validate.
    /// - returns: Whether or not this is valid.
    public func isValid(_ trust: SecTrust, domain: String?) -> Bool {
        return security.isValid(trust, domain: domain)
    }
}
