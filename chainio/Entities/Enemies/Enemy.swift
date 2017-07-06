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
        Enemy.atlas = SKTextureAtlas(named: "enemies.atlas")
        for i in 1...Enemy.atlas!.textureNames.count {
            let name = "enemy\(i).png"
            Enemy.textures.append(SKTexture(imageNamed: name))
        }
    }
    
    init() {
        let index: Int = Int(Utils.random(min: 1, max: 3))
        let texture = Enemy.atlas!.textureNamed("enemy_\(index).png")
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 15, height: 15) /*texture.size()*/)

        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        self.physicsBody?.contactTestBitMask = PhysicsCategory.None
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.fieldBitMask = PhysicsCategory.Blackhole
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(_ currentTime: TimeInterval) {
        if position.x < -size.width / 2 || position.y < -size.height / 2 || position.x > 1025 || position.y > 1025 { // TODO Better checks
            EnemyManager.removeEnemy(self)
            return
        }

        if let velocity = self.physicsBody?.velocity {
            let dx = (-150 ... 150).clamp(value: velocity.dx)
            let dy = (-150 ... 150).clamp(value: velocity.dy)
            self.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
        }
    }

    func destroy(pointsRewarded: Int, multiplier: Int) {
        let explosion = Explosion(multiplier: multiplier)
        explosion.position = self.position
        self.scene?.addChild(explosion)
        
        let points = Points(score: pointsRewarded)
        points.position = self.position
        self.scene?.addChild(points)
        points.animate()
        
        EnemyManager.removeEnemy(self)
    }

    func resetTrajectory() {
        self.run(SKAction.applyForce(CGVector(dx: -5, dy: 0), duration: 5))
    }
}
