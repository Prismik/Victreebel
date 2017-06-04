//
//  GravityProjectile.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-04.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class GravityProjectile: Projectile {

    init() {
        let texture = SKTexture(imageNamed: "projectile")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.setScale(0.8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.implode()
        ProjectileManager.removeProjectile(self)
    }

    override func collisionDidOccur() {
        self.implode()
        super.collisionDidOccur()
    }

    private func implode() {
        let blackhole = SKFieldNode.springField()
        blackhole.position = self.position
        blackhole.physicsBody?.categoryBitMask = PhysicsCategory.Blackhole
        blackhole.physicsBody?.fieldBitMask = PhysicsCategory.None
        blackhole.strength = 0.75
        blackhole.falloff = -0.75
        blackhole.region = SKRegion(radius: 125)

        blackhole.run(SKAction.sequence([
            SKAction.strength(to: 0, duration: 3),
            SKAction.removeFromParent(),
            SKAction.run(EnemyManager.resetTrajectories)
        ]))
        self.scene?.addChild(blackhole)
    }
}
