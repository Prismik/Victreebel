//
//  Bank.swift
//  chainio
//
//  Created by Francis Beauch on 2017-11-04.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class Bank: SKSpriteNode {
    static let texture: SKTexture = SKTexture(imageNamed: "roundTower")
    static let smallTexture: SKTexture = SKTexture(imageNamed: "coins")

    var absolutePotition: CGPoint {
        return (scene?.convert(position, from: self) ?? CGPoint.zero) + CGPoint(x: 0, y: height * 0.8)
    }

    private let interestGenerator: FundsGenerator = FundsGenerator(delay: 10)
    private let rate: CGFloat = 0.05

    required init() {
        let texture = ArrowTower.texture
        super.init(texture: texture, color: UIColor.clear, size: texture.size())

        interestGenerator.delegate = self
        
        anchorPoint = CGPoint(x: 0.5, y: 0)
        name = "Bank"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Bank: FundsGeneratorDelegate {
    func computeFunds() -> Int {
        return Int(ceil(CGFloat(GameProperties.funds) * rate))
    }
}

extension Bank: Construct {
    static var uiTexture: SKTexture {
        return smallTexture
    }

    var price: Int {
        return 50
    }

    func enableAugment() {
        interestGenerator.enable()
    }


    func availableUpgrades() -> [Construct.Type] {
        return [ArrowTower.self, ArrowTower.self, ArrowTower.self, ArrowTower.self]
    }
}
