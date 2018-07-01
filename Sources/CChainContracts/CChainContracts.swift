//
//  CChainContracts.swift
//  cchain-contracts-framework
//
//  Created by franz busch on 01.07.18.
//

import Vapor

public final class CChainContracts {

    let contracts: [Contract]
    let application: Application

    public init(contracts: [Contract]) throws {
        self.contracts = contracts
        let config = Config.default()
        let env = try Environment.detect()
        let services = Services.default()
        application = try Application(config: config, environment: env, services: services)
    }

    public func start() throws {
        try contracts.map { try $0.load(on: application) }.flatten(on: application).wait()
        for contract in contracts {
            schedule(contract: contract)
        }
        dispatchMain()
    }

    func schedule(contract: Contract) {
        let task = application.eventLoop.scheduleTask(in: .seconds(1)) {
            return try contract.process(on: self.application)
        }

        task.futureResult.whenComplete {
            self.schedule(contract: contract)
        }
    }

}
