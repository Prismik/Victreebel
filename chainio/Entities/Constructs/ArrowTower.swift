//
//  ArrowTower.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class ArrowTower: SKSpriteNode {
    static let texture: SKTexture = SKTexture(imageNamed: "roundTower")
    static let smallTexture: SKTexture = SKTexture(imageNamed: "arrows")
    static var uiTexture: SKTexture {
        return smallTexture
    }

    var price: Int {
        return 50
    }

    var absolutePotition: CGPoint {
        return (scene?.convert(position, from: self) ?? CGPoint.zero) + CGPoint(x: 0, y: height * 0.8)
    }

    private let shooter: ProjectileShooter = ProjectileShooter(delay: 1.25, range: 250, projectileType: PropagatingProjectile.self)
    required init() {
        let texture = ArrowTower.texture
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        shooter.delegate = self
        anchorPoint = CGPoint(x: 0.5, y: 0)
        name = "Arrow tower"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

extension ArrowTower: Construct {
    func enableAugment() {
        shooter.enable()
    }


    func availableUpgrades() -> [Construct.Type] {
        return [ArrowTower.self, ArrowTower.self, ArrowTower.self, ArrowTower.self]
    }
}

extension ArrowTower: AugmentDelegate {
    func playSound() {
        run(SKAction.playSoundFileNamed("laser", waitForCompletion: false))
    }
}
