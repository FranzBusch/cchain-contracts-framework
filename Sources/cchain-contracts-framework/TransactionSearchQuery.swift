//
//  TransactionSearchQuery.swift
//  App
//
//  Created by franz busch on 25.05.18.
//

import Vapor

public struct TransactionSearchQuery: Content {

    public let chainID: Int?
    public let sender: String?
    public let receiver: String?
    public let after: String?
    public let afterTransactionID: Int?
    public let last: Bool?

    public init(chainID: Int? = nil, sender: String? = nil, receiver: String? = nil, after: String? = nil, afterTransactionID: Int? = nil, last: Bool? = nil) {
        self.chainID = chainID
        self.sender = sender
        self.receiver = receiver
        self.after = after
        self.afterTransactionID = afterTransactionID
        self.last = last
    }

}
