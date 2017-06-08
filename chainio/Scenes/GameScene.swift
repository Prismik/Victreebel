//
//  GameScene.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-01-20.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit
import GameplayKit


struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Monster   : UInt32 = 0b1       // 1
    static let Projectile: UInt32 = 0b10      // 2
    static let Explosion : UInt32 = 0b100     // 4
    static let Blackhole : UInt32 = 0b1000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    private static let baseMultiplier: Int = 1
    
    var score: Int = 0
    var player: Player!
    var weapons: WeaponRail!
    var blackhole: SKFieldNode!

    // SKScene function (entry point)
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.black

        self.weapons = WeaponRail(parent: self)
        self.addChild(weapons)
        
//        self.player = Player()
//        self.player.position = self.weapons.activeTurret!.position
//        self.player.delegate = self.weapons
//        self.addChild(player)

        self.physicsWorld.gravity = CGVector.zero
        self.physicsWorld.contactDelegate = self

        ProjectileManager.scene = self
        EnemyManager.scene = self

        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 0.7)
            ])
        ))

        
        let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }

    override func update(_ currentTime: TimeInterval) {
        ProjectileManager.update(currentTime)
        EnemyManager.update(currentTime)
    }
    
    //SKPhysicsContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if shouldHandleCollision(firstBitMask: firstBody.categoryBitMask, secondBitMask: secondBody.categoryBitMask) {
            if let monster = firstBody.node as? Enemy, let
                entity = secondBody.node as? SKSpriteNode {
                entityDidCollideWithMonster(entity: entity, monster: monster)
            }
        }
        
    }
    
    private func shouldHandleCollision(firstBitMask: UInt32, secondBitMask: UInt32) -> Bool {
        return firstBitMask & PhysicsCategory.Monster != 0 &&
            (secondBitMask & PhysicsCategory.Projectile != 0 || secondBitMask & PhysicsCategory.Explosion != 0)
    }
    
    func addMonster() {
        let y = Utils.random(min: 0, max: 3)
        let actualY = self.weapons.turrets[Int(y)].position.y + Utils.random(min: -1, max: 1)
        
        let position = CGPoint(x: size.width + 50, y: actualY)
        EnemyManager.addEnemy(at: position, towards: CGVector(dx: -150, dy: 0))
    }

    // TODO Decide if using preset explosion patterns of ennemies with clickable nodes that propagate explosion to another enemy
    //      OR
    //      Using enemies with special explosions
    
    //      Remove the main story board and replace by SKPhysicsContactDelegate
    /*
             override func viewDidLoad() {
             super.viewDidLoad()
             view = SKView()
             }
             var skView: SKView {
             return view as! SKView
             }
     */
    func entityDidCollideWithMonster(entity: SKSpriteNode, monster: Enemy) {
        var multiplier: Int = GameScene.baseMultiplier
        if let projectile = entity as? Projectile {
            projectile.collisionDidOccur()
        }
        else if let explosion = entity as? Explosion {
            multiplier = explosion.multiplier + 1
        }
        
        let additionalScore: Int = monster.score * multiplier
        self.score += additionalScore
        
        monster.destroy(pointsRewarded: additionalScore, multiplier: multiplier)
    }

    var touchPosition: CGPoint = CGPoint.zero
}

extension GameScene {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        let finalPosition = touch.location(in: self)
        if finalPosition != touchPosition {
            let direction = CGVector(dx: finalPosition.x - touchPosition.x, dy: finalPosition.y - touchPosition.y).normalized()
            ProjectileManager.addProjectile(ofType: GravityProjectile.self, at: touchPosition, towards: direction * 200)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        touchPosition = touch.location(in: self)
    }
}
