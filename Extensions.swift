//
//  Extensions.swift
//  DSDev
//
//  Created by Satish Babariya on 4/17/18.
//  Copyright © 2018 Webmob Technologies. All rights reserved.
//

import Foundation
extension Dictionary {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func dict2json() -> String {
        return json
    }
}
