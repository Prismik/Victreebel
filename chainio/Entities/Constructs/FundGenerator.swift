//
//  FundGenerator.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class FundGenerator {
    private let generationDelay: TimeInterval
    private let generatedFunds: Int

    init(delay: TimeInterval, periodicFunds: Int) {
        self.generationDelay = delay
        self.generatedFunds = periodicFunds
        SKAction.repeatForever(
            SKAction.sequence([
                SKAction.wait(forDuration: generationDelay),
                SKAction.run(generate)
            ])
        )
    }

    func generate() {
        GameProperties.funds += generatedFunds
    }
}
