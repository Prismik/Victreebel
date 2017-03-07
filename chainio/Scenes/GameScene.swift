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
    let player = Player()
    
    // SKScene function (entry point)
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        self.player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector.zero
        self.physicsWorld.contactDelegate = self
        
        run(SKAction.repeatForever(
            SKAction.sequence([
        //        SKAction.run(addMonster),
                SKAction.wait(forDuration: 0.1)
                ])
        ))
        
        let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
    
    // SKNode function
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        let projectile = Projectile()
        projectile.position = player.position
        
        let offset = touchLocation - projectile.position
        if (offset.x < 0) {
            return
        }
        
        addChild(projectile)
        
        let direction = offset.normalized()
        let shootAmount = direction * 1000
        let finalDestination = shootAmount + projectile.position
        
        let actionMove = SKAction.move(to: finalDestination, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
        run(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
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
        let actualY = Utils.random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
        addChild(monster)
        
        // Determine speed of the monster
        let actualDuration = Utils.random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }

    // TODO Decide if using preset explosion patterns of ennemies with clickable nodes that propagate explosion to another enemy
    //      OR
    //      Using enemies with special explosions
    //      OR
    //      Pause mode to prepare shooting of different projectiles strategically
    //      
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
