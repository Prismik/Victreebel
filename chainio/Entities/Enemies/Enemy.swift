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
    private(set) var health: Int = 100
    private(set) var score: Int = 100

    private static var atlas: SKTextureAtlas? = nil
    private static var textures: [SKTexture] = []
    private static var count: Int = 0

    public let elements: [Element.Type] = [Fire.self]
    
    var isDead: Bool {
        get { return health <= 0 }
    }
    
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

        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.Monster
        physicsBody?.contactTestBitMask = PhysicsCategory.None
        physicsBody?.collisionBitMask = PhysicsCategory.None
        physicsBody?.fieldBitMask = PhysicsCategory.Blackhole
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(_ currentTime: TimeInterval) {
        if position.x < -size.width / 2 || position.y < -size.height / 2 || position.x > 1025 || position.y > 1025 { // TODO Better checks
            EnemyManager.removeEnemy(self)
            return
        }

        if let velocity = physicsBody?.velocity {
            let dx = (-150 ... 150).clamp(value: velocity.dx)
            let dy = (-150 ... 150).clamp(value: velocity.dy)
            physicsBody?.velocity = CGVector(dx: dx, dy: dy)
        }
    }

    var doIt: Bool = true
    // TODO Damage type system + resistances
    func hurt(damage: Int, type: Int) {
        if type == 2 {
            health -= damage
        }
        
        let colorFlash: SKAction = SKAction.sequence([
            SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.15),
            SKAction.colorize(with: .white, colorBlendFactor: 1.0, duration: 0.15)
        ])
        run(SKAction.group([
            colorFlash,
            SKAction.playSoundFileNamed("explosion_2.wav", waitForCompletion: false)
        ]))
        if doIt {
            damageOverTime(totalDamage: 100, damagePerSecond: 50)
            doIt = false
        }

        if isDead {
            destroy(pointsRewarded: score, multiplier: 1)
        }
    }

    func damageOverTime(totalDamage: Int, damagePerSecond: Int) {
        let numberOfTick: Int = totalDamage / damagePerSecond
        let sequence: SKAction = SKAction.sequence([
            SKAction.run({ [weak self] in
                if let strongSelf = self {
                    strongSelf.hurt(damage: damagePerSecond, type: 2)
                }
            }),
            SKAction.wait(forDuration: 1)
        ])

        run(SKAction.repeat(sequence, count: numberOfTick))
    }

    func destroy(pointsRewarded: Int, multiplier: Int) {
        let explosion = Explosion(multiplier: multiplier)
        explosion.position = position
        self.scene?.addChild(explosion)
        
        let points = Points(score: pointsRewarded)
        points.position = position
        scene?.addChild(points)
        points.animate()
        
        EnemyManager.removeEnemy(self)
    }

    func resetTrajectory() {
        self.run(SKAction.applyForce(CGVector(dx: -5, dy: 0), duration: 5))
    }
}
