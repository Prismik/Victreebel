//
//  MagicTower.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-15.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class MagicTower: Construct {
    static let texture: SKTexture = SKTexture(imageNamed: "magicTower")

    override var absolutePotition: CGPoint {
        return super.absolutePotition + CGPoint(x: 0, y: height * 0.8)
    }

    private let shooter: ProjectileShooter = ProjectileShooter(delay: 0.7, range: 500, projectileType: FlameProjectile.self)
    required init() {
        super.init(texture: MagicTower.texture, price: 50, name: "Magic tower")
        shooter.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc   override func enableAugment() {
        shooter.enable()
    }

    override func playSound() {
        run(SKAction.playSoundFileNamed("fireball", waitForCompletion: false))
    }
}
