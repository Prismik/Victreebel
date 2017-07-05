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
    private let position: CGPoint = CGPoint.zero

    init(delay: TimeInterval, range: CGFloat) {
        self.shootDelay = delay
        self.maximumRange = range
    }

    deinit {
        timer.invalidate()
    }

    func enable() {
        self.timer = Timer.scheduledTimer(timeInterval: shootDelay, target: self, selector: #selector(ProjectileShooter.prepareToShoot), userInfo: nil, repeats: true)
    }

    @objc
    private func prepareToShoot() {
        if let enemy = EnemyManager.getClosestEnemy(from: position) {
            shoot(at: enemy)
        }
    }

    private func shoot(at enemy: SKSpriteNode) {
        if let position = delegate?.getPosition() {
            let direction: CGVector = (enemy.position - position).asVector().normalized()
            ProjectileManager.addProjectile(ofType: PropagatingProjectile.self, at: position, towards: direction * 500)
        }
    }
}
