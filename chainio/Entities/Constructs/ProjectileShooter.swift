//
//  ProjectileShooter.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-17.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class ProjectileShooter {
    let shootDelay: TimeInterval
    let maximumRange: CGFloat
    init(delay: TimeInterval, range: CGFloat) {
        self.shootDelay = delay
        self.maximumRange = range
    }

    func shoot(at enemy: SKSpriteNode) {
        
    }
}
