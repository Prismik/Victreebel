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
    
    init() {
        let texture = SKTexture(imageNamed: "projectile")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func destroy() {
        self.removeFromParent()
    }
}
