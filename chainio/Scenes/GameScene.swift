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
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    private static let baseMultiplier: Int = 1
    
    var score: Int = 0
    var player: Player!
    var weapons: WeaponRail!
    
    // SKScene function (entry point)
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.black
    
        self.weapons = WeaponRail(parent: self)
        self.addChild(weapons)
        
        self.player = Player()
        self.player.position = self.weapons.activeTurret!.position
        self.player.delegate = self.weapons
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector.zero
        self.physicsWorld.contactDelegate = self

        ProjectileManager.scene = self

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
    }

    // SKNode function
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        
        self.weapons.shoot()
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
        let monster = Enemy()
        
        // Determine where to spawn the monster along the Y axis
        let y = Utils.random(min: 0, max: 3)
        let actualY = self.weapons.turrets[Int(y)].position.y + Utils.random(min: -1, max: 1)
        
        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
        addChild(monster)
        
        let move: SKAction = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY), duration: TimeInterval(4.0))
        //let oscillate: SKAction = SKAction.repeat(SKAction.oscillation(amplitude: 10.0, timePeriod: 1.5, midPoint: monster.position), count: 5)
        //let actionGroup: SKAction = SKAction.group([move, oscillate])
        let actionsDone: SKAction = SKAction.removeFromParent()
        monster.run(SKAction.sequence([move, actionsDone]))
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
            projectile.removeFromParent()
        }
        else if let explosion = entity as? Explosion {
            multiplier = explosion.multiplier + 1
        }
        
        let additionalScore: Int = monster.score * multiplier
        self.score += additionalScore
        
        monster.destroy(pointsRewarded: additionalScore, multiplier: multiplier)
    }
}
