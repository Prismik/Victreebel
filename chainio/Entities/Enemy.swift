//
//  Enemy.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-02.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    private static var atlas: SKTextureAtlas? = nil
    private static var textures: [SKTexture] = []
    private static var count: Int = 0
    
    private(set) var score: Int = 100
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
        let texture = SKTexture(imageNamed: "monster")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func destroy(pointsRewarded: Int, multiplier: Int) {
        let explosion = Explosion(multiplier: multiplier)
        explosion.position = self.position
        self.scene?.addChild(explosion)
        
        let points = Points(score: pointsRewarded)
        points.position = self.position
        self.scene?.addChild(points)
        points.animate()
        
        self.removeFromParent()
    }
}
