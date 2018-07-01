//
//  Contract.swift
//  App
//
//  Created by franz busch on 25.05.18.
//

import Vapor

public protocol Contract {

    func load(on container: Container) throws -> Future<Void>
    func process(on container: Container) throws -> Future<Void>

}
