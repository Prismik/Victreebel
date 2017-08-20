//
//  HealthIndicator.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-08-03.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class HealthIndicator: SKSpriteNode {
    let redBackground: SKSpriteNode
    let healthBar: SKSpriteNode

    let totalHealth: Int
    var health: Int {
        didSet {
            layoutHealthBar()
        }
    }
    
    private let healthBarHeight: CGFloat = 5
    init(width: CGFloat, totalHealth: Int) {
        self.totalHealth = totalHealth
        self.health = totalHealth
        let size: CGSize = CGSize(width: width, height: healthBarHeight)
        self.redBackground = SKSpriteNode(color: .red, size: size)
        self.healthBar = SKSpriteNode(color: .green, size: size)
        super.init(texture: nil, color: .clear, size: size)

        redBackground.anchorPoint = CGPoint(x: 0, y: 0)
        redBackground.zPosition = zPosition + 0.1
        addChild(redBackground)

        healthBar.anchorPoint = CGPoint(x: 0, y: 0)
        healthBar.zPosition = zPosition + 0.2
        addChild(healthBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutHealthBar() {
        healthBar.xScale = CGFloat(health) / CGFloat(totalHealth)
    }
}
