//
//  JWTPayload.swift
//  App
//
//  Created by franz busch on 25.05.18.
//

import Vapor
import JWT

public struct JWTTokenPayload: JWTPayload {

    public var sub: SubjectClaim
    public var exp: ExpirationClaim

    public func verify() throws {
        try exp.verify()
    }
}
