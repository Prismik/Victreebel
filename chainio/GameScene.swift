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
    
    let player = SKSpriteNode(imageNamed: "Spaceship")
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        self.player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        self.player.size = CGSize(width: 40, height: 40)
        self.player.zRotation = -CGFloat.pi / 2
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector.zero
        self.physicsWorld.contactDelegate = self
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 0.1)
                ])
        ))
        
        let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
    
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
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        let monster = Enemy()
        
        // Determine where to spawn the monster along the Y axis
        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
        addChild(monster)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }

    func entityDidCollideWithMonster(entity: SKSpriteNode, monster: Enemy) {
        if let projectile = entity as? Projectile {
            projectile.removeFromParent()
        }
        
        monster.destroy()
    }
}
