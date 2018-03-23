//
//  Messae.swift
//  DeepStreamDemo
//
//  Created by Satish on 23/03/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

struct Message: Codable {
    var topic: Topic
    var action: Action
    var data: [String]
    var raw: String?
}


