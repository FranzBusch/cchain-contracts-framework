//
//  ContractDocumentStrategy.swift
//  App
//
//  Created by franz busch on 26.05.18.
//

import Vapor

public protocol DocumentStrategy {

    var contractDocumentType: RequestDocument.Type { get }

    func isStrategy(for document: RequestDocument) -> Bool
    func process(_ document: RequestDocument, on container: Container) throws -> Future<ResponseDocument>

}
