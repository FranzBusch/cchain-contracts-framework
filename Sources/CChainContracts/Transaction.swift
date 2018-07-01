//
//  Transaction.swift
//  App
//
//  Created by franz busch on 25.05.18.
//

import Vapor
import Crypto

public final class Transaction: Content {

    public var id: Int?

    public var chainID: Int
    public var sender: String
    public var receiver: String
    public var senderEncryptionKey: String?
    public var receiverEncryptionKey: String?
    public var document: String
    public var signature: String
    public var createdAt: Date

    public init(chainID: Int,
         sender: String,
         receiver: String,
         senderEncryptionKey: String? = nil,
         receiverEncryptionKey: String? = nil,
         document: String,
         signature: String,
         createdAt: Date
        ) {
        self.chainID = chainID
        self.sender = sender
        self.receiver = receiver
        self.senderEncryptionKey = senderEncryptionKey
        self.receiverEncryptionKey = receiverEncryptionKey
        self.document = document
        self.signature = signature
        self.createdAt = createdAt
    }

    public func decrypt(with key: RSAKey, privateKey: RSAKey) throws {
    }

}
