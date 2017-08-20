//
//  Projectile.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-02.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class Projectile: SKSpriteNode {
    private static var count: Int = 0

    let damage: Int = 20

    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

        name = "projectile"
        zRotation = CGFloat.pi / 2
        isUserInteractionEnabled = true
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        physicsBody?.collisionBitMask = PhysicsCategory.None
        physicsBody?.fieldBitMask = PhysicsCategory.None
        physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(_ currentTime: TimeInterval) {
        if let scene = self.scene {
            let halfWidth = self.size.width / 2
            if self.position.x < -halfWidth || self.position.x > scene.size.width + halfWidth
                || self.position.y < -halfWidth || self.position.y > scene.size.height + halfWidth {
                ProjectileManager.removeProjectile(self)
            }
        }
    }

    func collisionDidOccur() {
        ProjectileManager.removeProjectile(self)
    }
}
