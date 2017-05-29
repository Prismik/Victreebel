//
//  ProjectileManager.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-05-28.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class ProjectileManager {
    static private var projectiles: [Projectile] = []

    static var scene: SKScene?

    class func update(_ currentTime: TimeInterval) {
        for projectile in ProjectileManager.projectiles {
            projectile.update(currentTime)
        }
    }

    class func addProjectile(at position: CGPoint, towards direction: CGVector) {
        if let containerScene = scene {
            let projectile = Projectile()
            projectile.position = position
            projectile.zRotation = direction.angle
            projectile.physicsBody?.velocity = direction
            containerScene.addChild(projectile)
        }
    }

    class func removeProjectile(projectile: Projectile) {
        projectile.removeFromParent()
    }
}
