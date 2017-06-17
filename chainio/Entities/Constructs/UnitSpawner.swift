//
//  UnitSpawner.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class UnitSpawner {
    let unitsLimit: Int
    let spawnDelay: TimeInterval

    private var associatedUnits: [String] = []

    init(delay: TimeInterval, limit: Int) {
        self.unitsLimit = limit
        self.spawnDelay = delay
        SKAction.repeatForever(
            SKAction.sequence([
                SKAction.wait(forDuration: spawnDelay),
                SKAction.run(spawn)
            ])
        )
    }

    func spawn() {
        if associatedUnits.count < unitsLimit {
            associatedUnits.append("unit")
        }
    }
}
