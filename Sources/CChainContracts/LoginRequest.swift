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

}
