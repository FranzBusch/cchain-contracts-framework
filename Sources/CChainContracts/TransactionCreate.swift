//
//  TransactionCreate.swift
//  App
//
//  Created by franz busch on 26.05.18.
//

import Vapor
import Crypto

public final class TransactionCreate: Content {

    public var id: Int?

    public var chainID: Int
    public var sender: String
    public var receiverPublicKey: String
    public var senderEncryptionKey: String?
    public var receiverEncryptionKey: String?
    public var document: String
    public var signature: String?

    public init(chainID: Int,
         sender: String,
         receiverPublicKey: String,
         senderEncryptionKey: String? = nil,
         receiverEncryptionKey: String? = nil,
         document: String,
         signature: String? = nil
        ) {
        self.chainID = chainID
        self.sender = sender
        self.receiverPublicKey = receiverPublicKey
        self.senderEncryptionKey = senderEncryptionKey
        self.receiverEncryptionKey = receiverEncryptionKey
        self.document = document
        self.signature = signature
    }

    public func sign(with key: RSAKey) throws {
        signature = try RSA.SHA256.sign(document, key: key).base64EncodedString()
    }
    
}
