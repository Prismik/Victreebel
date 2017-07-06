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

    weak var delegate: AugmentDelegate?

    private var timer: Timer = Timer()
    private var associatedUnits: [String] = []

    init(delay: TimeInterval, limit: Int) {
        self.unitsLimit = limit
        self.spawnDelay = delay
    }

    deinit {
        timer.invalidate()
    }
    
    func enable() {
        timer = Timer.scheduledTimer(timeInterval: spawnDelay, target: self, selector: #selector(UnitSpawner.spawn), userInfo: nil, repeats: true)
    }


    @objc
    private func spawn() {
        if associatedUnits.count < unitsLimit {
            associatedUnits.append("unit")
        }
    }
}
