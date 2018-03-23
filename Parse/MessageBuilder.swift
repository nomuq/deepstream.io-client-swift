//
//  MessageBuilder.swift
//  DeepStreamDemo
//
//  Created by Satish on 23/03/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

func buildMessage(Topic topic: Topic, Action action: Action, Data data: [String]) -> String {
    var string : String = topic.rawValue + Constants.messageUnitSeparator + action.rawValue
    for item in data{
        string = string + Constants.messageUnitSeparator + item
    }
    return string + Constants.messageRecordSeparator
}
