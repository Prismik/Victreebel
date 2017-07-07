//
//  CollisionManager.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-06.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Monster   : UInt32 = 0b1       // 1
    static let Projectile: UInt32 = 0b10      // 2
    static let Explosion : UInt32 = 0b100     // 4
    static let Blackhole : UInt32 = 0b1000
}

class CollisionManager: NSObject {
    override init() {

    }
}

extension CollisionManager: SKPhysicsContactDelegate {
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
                entity = secondBody.node as? SKSpriteNode, entity.parent != nil {
                entityDidCollideWithMonster(entity: entity, monster: monster)
            }
        }
    }

    private func shouldHandleCollision(firstBitMask: UInt32, secondBitMask: UInt32) -> Bool {
        return firstBitMask & PhysicsCategory.Monster != 0 &&
            (secondBitMask & PhysicsCategory.Projectile != 0 || secondBitMask & PhysicsCategory.Explosion != 0)
    }

    func entityDidCollideWithMonster(entity: SKSpriteNode, monster: Enemy) {
        if let projectile: Projectile = entity as? Projectile {
            projectile.physicsBody?.categoryBitMask = PhysicsCategory.None
            monster.hurt(damage: projectile.damage, type: 1)
            projectile.collisionDidOccur()

        }
        else if let explosion = entity as? Explosion {
//            multiplier = explosion.multiplier + 1
            monster.hurt(damage: 75, type: 3)
        }
    }
}
