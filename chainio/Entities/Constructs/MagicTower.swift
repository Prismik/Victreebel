//
//  MagicTower.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-15.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class MagicTower: SKSpriteNode {
    static let texture: SKTexture = SKTexture(imageNamed: "magicTower")
    static let smallTexture: SKTexture = SKTexture(imageNamed: "spell")
    static var uiTexture: SKTexture {
        return smallTexture
    }

    var price: Int {
        return 50
    }
    
    var absolutePotition: CGPoint {
        return (scene?.convert(position, from: self) ?? CGPoint.zero) + CGPoint(x: 0, y: height * 0.8)
    }
    
    private let shooter: ProjectileShooter = ProjectileShooter(delay: 0.7, range: 500, projectileType: FlameProjectile.self)
    required init() {
        let texture = MagicTower.texture
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        shooter.delegate = self
        anchorPoint = CGPoint(x: 0.5, y: 0)
        name = "Magic tower"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MagicTower: Construct {
    func enableAugment() {
        shooter.enable()
    }

    func availableUpgrades() -> [Construct.Type] {
        return [MagicTower.self, MagicTower.self, MagicTower.self, MagicTower.self]
    }
}

extension MagicTower: AugmentDelegate {
    func playSound() {
        run(SKAction.playSoundFileNamed("fireball", waitForCompletion: false))
    }
}
