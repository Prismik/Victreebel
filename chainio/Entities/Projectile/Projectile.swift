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
    private static var atlas: SKTextureAtlas? = nil
    private static var textures: [SKTexture] = []
    private static var count: Int = 0
    
    public class func loadTextures() {
        /*
         Enemy.atlas = SKTextureAtlas(named: "explosion.atlas")
         for i in 1...Enemy.atlas!.textureNames.count {
         let name = "enemy\(i).png"
         Explosion.textures.append(SKTexture(imageNamed: name))
         }
         */
    }

    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

        self.name = "projectile"
        self.zRotation = CGFloat.pi / 2
        self.isUserInteractionEnabled = true
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.fieldBitMask = PhysicsCategory.None
        self.physicsBody?.usesPreciseCollisionDetection = true
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
