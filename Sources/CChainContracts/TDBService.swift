//
//  TDBService.swift
//  App
//
//  Created by franz busch on 25.05.18.
//

import Vapor
import JWT

public class TDBService {

    public var jwtToken: String?
    public var jwtTokenPayload: JWTTokenPayload?
    public var loginRequest: LoginRequest

    let host: String

    public init(loginRequest: LoginRequest, host: String) {
        self.host = host
        self.loginRequest = loginRequest
    }

    public func fetchTransactions(with query: TransactionSearchQuery, on container: Container) throws -> Future<[Transaction]> {
        let client = try container.client()

        return try loginIfNecessary(on: container).flatMap { loginResponse in
            let headers = HTTPHeaders([("Authorization", loginResponse.token)])

            return client.get("\(self.host)/transactions", headers: headers) { request in
                return try request.query.encode(query)
            }.flatMap { response in
                return try response.content.decode([Transaction].self)
            }
        }

    }

    public func createTransaction(_ transaction: TransactionCreate, on container: Container) throws -> Future<Transaction> {
        let client = try container.client()

        return try loginIfNecessary(on: container).flatMap { loginResponse in
            let headers = HTTPHeaders([("Authorization", loginResponse.token)])

            return client.post("\(self.host)/transactions", headers: headers) { request in
                return try request.content.encode(transaction)
            }.flatMap { response in
                return try response.content.decode(Transaction.self)
            }
        }
    }

    public func fetchChains(on container: Container) throws -> Future<[Chain]> {
        let client = try container.client()

        return try loginIfNecessary(on: container).flatMap { loginResponse in
            let headers = HTTPHeaders([("Authorization", loginResponse.token)])

            return client.get("\(self.host)/chains", headers: headers).flatMap { response in
                return try response.content.decode([Chain].self)
            }
        }
    }

    public func createChain(_ chain: Chain, on container: Container) throws -> Future<Chain> {
        let client = try container.client()

        return try loginIfNecessary(on: container).flatMap { loginResponse in
            let headers = HTTPHeaders([("Authorization", loginResponse.token)])

            return client.post("\(self.host)/chains", headers: headers) { request in
                return try request.content.encode(chain)
            }.flatMap { response in
                return try response.content.decode(Chain.self)
            }
        }
    }

    public func fetchOrCreateChain(named name: String, on container: Container) throws -> Future<Chain> {
        return try fetchChains(on: container).flatMap(to: Chain.self) { chains in
            guard let chain = chains.first(where: { $0.name == name }) else {
                let carChain = Chain(name: name, description: name)
                return try self.createChain(carChain, on: container)
            }

            return container.eventLoop.newSucceededFuture(result: chain)
        }
    }

    private func loginIfNecessary(on container: Container) throws -> Future<LoginResponse> {
        guard let jwtToken = jwtToken else {
            return try login(with: loginRequest, on: container)
        }

        guard let data = jwtToken.data(using: .utf8) else {
            throw Abort(.internalServerError)
        }

        jwtTokenPayload = try JWT<JWTTokenPayload>(unverifiedFrom: data).payload

        guard let jwtTokenPayload = jwtTokenPayload else {
            return try login(with: loginRequest, on: container)
        }

        do {
            try jwtTokenPayload.verify()
            return container.eventLoop.newSucceededFuture(result: LoginResponse(token: jwtToken))
        } catch {
            return try login(with: loginRequest, on: container)
        }
    }

    private func login(with loginRequest: LoginRequest, on container: Container) throws -> Future<LoginResponse> {
        let client = try container.client()

        return client.post("\(self.host)/users/login") { request in
            return try request.content.encode(loginRequest)
        }.flatMap { response in
            return try response.content.decode(LoginResponse.self)
        }.map { loginResponse in
            self.jwtToken = loginResponse.token

            return loginResponse
        }
    }

}
