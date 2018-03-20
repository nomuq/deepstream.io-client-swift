//
//  Enums.swift
//  DeepstreamIO-iOS
//
//  Created by Satish on 20/03/18.
//  Copyright © 2018 satishbabariya. All rights reserved.
//

import Foundation

enum Action : String{
    case Error = "E"
    case Ping = "PI"
    case Pong = "PO"
    case Ack = "A"
    case Redirect = "RED"
    case Challenge = "CH"
    case ChallengeResponse = "CHR"
    case Read = "R"
    case Create = "C"
    case CreateOrRead = "CR"
    case CreateAndUpdate = "CU"
    case Update = "U"
    case Patch = "P"
    case Delete = "D"
    case Subscribe = "S"
    case Unsubscribe = "US"
    case Has = "H"
    case Snapshot = "SN"
    case SubscriptionForPatternFound = "SP"
    case SubscriptionForPatternRemoved = "SR"
    case SubscriptionHasProvider = "SH"
    case Listen = "L"
    case Unlisten = "UL"
    case ListenAccept = "LA"
    case ListenReject = "LR"
    case Event = "EVT"
    case Request = "REQ"
    case Response = "RES"
    case Rejection = "REJ"
    case PresenceJoin = "PNJ"
    case PresenceLeave = "PNL"
    case Query = "Q"
    case WriteAcknowledgement = "WA"
}

enum ConnectionState: String {
    case Closed = "CLOSED"
    case AwaitingConnection = "AWAITING_CONNECTION"
    case Challenging = "CHALLENGING"
    case AwaitingAuthentication = "AWAITING_AUTHENTICATION"
    case Authenticating = "AUTHENTICATING"
    case Open = "OPEN"
    case Error = "ERROR"
    case Reconnecting = "RECONNECTING"
}

enum GlobalConnectivityState : String{
    case Connected = "CONNECTED"
    case Disconnected = "DISCONNECTED"
}

enum Event: String{
    case UnauthenticatedConnectiontimeout = "UNAUTHENTICATED_CONNECTION_TIMEOUT"
    case ConnectionError = "CONNECTION_ERROR"
    case ConnectionStateChanged = "CONNECTION_STATE_CHANGED"
    case AckTimeout = "ACK_TIMEOUT"
    case InvalidAuthData = "INVALID_AUTH_DATA"
    case ResponseTimeout = "RESPONSE_TIMEOUT"
    case CacheRetrievalTimeout = "CACHE_RETRIEVAL_TIMEOUT"
    case StorageRetrievalTimeout = "STORAGE_RETRIEVAL_TIMEOUT"
    case DeleteTimeout = "DELETE_TIMEOUT"
    case UnsolicitedMessage = "UNSOLICITED_MESSAGE"
    case MessageParseError = "MESSAGE_PARSE_ERROR"
    case VersionExists = "VERSION_EXISTS"
    case NotAuthenticated = "NOT_AUTHENTICATED"
    case ListenerExists = "LISTENER_EXISTS"
    case NotListening = "NOT_LISTENING"
    case TooManyAuthAttempts = "TOO_MANY_AUTH_ATTEMPTS"
    case IsClosed = "IS_CLOSED"
    case RecordNotFound = "RECORD_NOT_FOUND"
    case MessageDenied = "MESSAGE_DENIED"
    case MultipleSubscriptions = "MULTIPLE_SUBSCRIPTIONS"
}


enum Type: String {
    case String = "S"
    case Object = "O"
    case Number = "N"
    case Null = "L"
    case True = "T"
    case False = "F"
    case Undefined = "U"
}

enum Topic: String {
    case Connection = "C"
    case Auth = "A"
    case Error = "X"
    case Event = "E"
    case Record = "R"
    case RPC = "P"
    case Presence = "U"
}

enum RecordMergeStrategy: String {
    case RemoteWins = "REMOTE_WINS"
    case LocalWins = "LOCAL_WINS"
}

struct Constants {
    static let messageUnitSeparator : String  = ""
    static let messageRecordSeparator : String = ""
}
