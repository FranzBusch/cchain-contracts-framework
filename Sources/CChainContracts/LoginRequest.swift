//
//  LoginRequest.swift
//  App
//
//  Created by franz busch on 25.05.18.
//

import Vapor

public struct LoginRequest: Content {

    public let publicKey: String
    public let token: String
    public let signature: String

    public init(publicKey: String, token: String, signature: String) {
        self.publicKey = publicKey
        self.token = token
        self.signature = signature
    }

}
