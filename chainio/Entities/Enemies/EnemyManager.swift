//
//  EnemyManager.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-04.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyManager {
    static private var enemies: [Enemy] = []

    static var scene: SKScene?

    class func update(_ currentTime: TimeInterval) {
        for enemy in EnemyManager.enemies {
            enemy.update(currentTime)
        }
    }

    class func addEnemy(at position: CGPoint, towards direction: CGVector) {
        if let containerScene = scene {
            let enemy = Enemy()
            enemy.position = position
            enemy.zPosition = 999
            enemy.zRotation = direction.angle
            enemy.physicsBody?.velocity = direction
            containerScene.addChild(enemy)
            EnemyManager.enemies.append(enemy)
        }
    }

    class func addEnemy(at position: CGPoint, following path: [CGPoint], during interval: TimeInterval) {
        if let containerScene = scene {
            let enemy = Enemy()
            enemy.position = position
            enemy.zPosition = 999
            containerScene.addChild(enemy)
            EnemyManager.enemies.append(enemy)
            enemy.run(PathManager.createPath(using: path, with: interval))
        }
    }

    class func removeEnemy(_ enemy: Enemy) {
        enemy.removeFromParent()
        if let index = EnemyManager.enemies.index(of: enemy) {
            EnemyManager.enemies.remove(at: index)
        }
    }

    class func resetTrajectories() {
        for enemy in EnemyManager.enemies {
            enemy.resetTrajectory()
        }
    }

    class func getClosestEnemy(from point: CGPoint) -> Enemy? {
        var closestEnemy: Enemy? = nil
        var comparedLength: CGFloat = .greatestFiniteMagnitude
        for enemy in enemies {
            let length = (enemy.position - point).asVector().length()
            if closestEnemy != nil {
                if  length < comparedLength {
                    comparedLength = length
                    closestEnemy = enemy
                }
            } else {
                closestEnemy = enemy
                comparedLength = length
            }
        }
        return closestEnemy
    }
}
