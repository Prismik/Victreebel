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

    public var canPropagate: Bool = true

    init() {
        let texture = SKTexture(imageNamed: "laser")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())

        self.name = "projectile"
        self.setScale(0.2)
        self.zRotation = CGFloat.pi / 2
        self.isUserInteractionEnabled = true
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.canPropagate {
            propagate()
        }
    }

    public func update(_ currentTime: TimeInterval) {
        if let scene = self.scene {
            if !scene.contains(self.position) {
                self.removeFromParent()
            }
        }
    }
    
    public func destroy() {
        self.removeFromParent()
    }

    private func propagate() {
        ProjectileManager.addProjectile(at: self.position, towards: CGVector(dx: 0, dy: 150))
        ProjectileManager.addProjectile(at: self.position, towards: CGVector(dx: 0, dy: -150))
        ProjectileManager.addProjectile(at: self.position, towards: CGVector(dx: 150, dy: 150))
        ProjectileManager.addProjectile(at: self.position, towards: CGVector(dx: 150, dy: -150))
        self.removeFromParent()
    }
}
