//
//  PropagatingProjectile.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-04.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class PropagatingProjectile: Projectile {
    init() {
        let texture = SKTexture(imageNamed: "laser")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())

        zPosition = 998
        setScale(0.2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.propagate()
        ProjectileManager.removeProjectile(self)
    }

    override func collisionDidOccur() {
        self.propagate()
        super.collisionDidOccur()
    }

    private func propagate() {
//        ProjectileManager.addProjectile(ofType: PropagatingProjectile.self, at: self.position, towards: CGVector(dx: 0, dy: 150))
//        ProjectileManager.addProjectile(ofType: PropagatingProjectile.self, at: self.position, towards: CGVector(dx: 0, dy: -150))
//        ProjectileManager.addProjectile(ofType: PropagatingProjectile.self, at: self.position, towards: CGVector(dx: 150, dy: 150))
//        ProjectileManager.addProjectile(ofType: PropagatingProjectile.self, at: self.position, towards: CGVector(dx: 150, dy: -150))
    }
}
