//
//  EnemySpawner.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-05.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class EnemySpawner {
    var position: CGPoint = CGPoint.zero
    var path: [CGPoint] = []

    private let travelInterval: TimeInterval = 6
    private var timer: Timer = Timer()
    init() {

    }

    deinit {
        timer.invalidate()
    }

    func activate() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(EnemySpawner.spawn), userInfo: nil, repeats: true)
    }


    @objc
    private func spawn() {
        EnemyManager.addEnemy(at: position, following: path, during: travelInterval)
    }
}
