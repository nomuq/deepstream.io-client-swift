//
//  Parser.swift
//  DeepStreamDemo
//
//  Created by Satish on 23/03/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation


func parse(Message message: String) -> Message? {
    for item in message.components(separatedBy: Constants.messageRecordSeparator) {
        var array: [String] = item.components(separatedBy: Constants.messageUnitSeparator)

        if item.count == 0 || item == "" || array.count < 2 {
            return nil
        }

        guard let topic: Topic = Topic(rawValue: array[0]) else {
            return nil
        }

        guard let action: Action = Action(rawValue: array[1]) else {
            return nil
        }

        array.remove(at: 0)
        array.remove(at: 0)

        return Message(topic: topic, action: action, data: array, raw: nil)

    }

    return nil

}
