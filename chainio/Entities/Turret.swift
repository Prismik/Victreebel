//
//  Turret.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-11.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class Turret: SKSpriteNode {
    private static var atlas: SKTextureAtlas? = nil
    public class func loadTextures() {
        Turret.atlas = SKTextureAtlas(named: "turrets.atlas")
    }
    
    init() {
        let texture = Turret.atlas?.textureNamed("turret_01.png")
        super.init(texture: texture, color: SKColor.clear, size: texture!.size())
        self.setScale(0.4)
        self.zRotation = -CGFloat.pi / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func shoot() {
        ProjectileManager.addProjectile(at: self.position, towards: CGVector(dx: 400, dy: 0))

        // TODO Each projectile should have their own sound / image associated with it
        run(SKAction.playSoundFileNamed("laser.wav", waitForCompletion: false))
    }
}
