//
//  ArrowTower.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class ArrowTower: Construct {
    static let texture: SKTexture = SKTexture(imageNamed: "roundTower")
    private let shooter: ProjectileShooter = ProjectileShooter(delay: 1.25, range: 250)
    required init() {
        super.init(texture: ArrowTower.texture, price: 50, name: "Arrow tower")
        shooter.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func enableAugment() {
        shooter.enable()
    }
}
