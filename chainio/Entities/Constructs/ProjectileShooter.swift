//
//  ProjectileShooter.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-17.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class ProjectileShooter {
    let shootDelay: TimeInterval
    let maximumRange: CGFloat

    weak var delegate: AugmentDelegate?

    private var timer: Timer = Timer()
    private let projectile: Projectile.Type

    init(delay: TimeInterval, range: CGFloat, projectileType: Projectile.Type) {
        self.shootDelay = delay
        self.maximumRange = range
        self.projectile = projectileType
    }

    deinit {
        timer.invalidate()
    }

    func enable() {
        timer = Timer.scheduledTimer(timeInterval: shootDelay, target: self, selector: #selector(ProjectileShooter.prepareToShoot), userInfo: nil, repeats: true)
    }

    @objc
    private func prepareToShoot() {
        if let position = delegate?.absolutePotition, let enemy = EnemyManager.getClosestEnemy(from: position) {
            let deltaPosition: CGVector = (enemy.position - position).asVector()
            if deltaPosition.length() <= maximumRange {
                shoot(from: position, towards: deltaPosition.normalized())
            }
        }
    }

    // TODO Delegate the shooting to the parent, as he knows how many projectiles to shoot
    private func shoot(from position: CGPoint, towards direction: CGVector) {
        ProjectileManager.addProjectile(ofType: projectile, at: position, towards: direction * 200)
        delegate?.playSound()
    }
}
