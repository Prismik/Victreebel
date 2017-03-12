//
//  WeaponRail.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-11.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class WeaponRail: SKSpriteNode {
    var activeTurret: Turret?
    var turrets: [Turret] = []
    
    init(parent: SKScene) {
        let texture = SKTexture()
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 25, height: parent.size.height))
        self.position = CGPoint(x: self.size.width / 2, y: 0)
        
        let height = self.size.height * 0.8
        var turretPosition: CGFloat = self.size.height * 0.1
        for _ in 0...3 {
            let turret = Turret()
            turret.position = CGPoint(x: self.position.x, y: turretPosition)
            turretPosition += height / 3
            self.turrets.append(turret)
            self.addChild(turret)
        }
        
        self.activeTurret = self.turrets.first
    }
    
    public func shoot() {
        self.activeTurret?.shoot()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
