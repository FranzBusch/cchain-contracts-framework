//
//  Chain.swift
//  App
//
//  Created by franz busch on 25.05.18.
//

import Vapor

public final class Chain: Content {

    public var id: Int?

    public var name: String
    public var description: String

    public var owner: String?

    public init(name: String, description: String, owner: String? = nil) {
        self.name = name
        self.description = description
        self.owner = owner
    }

}
