//
//  CoreRune.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-03-30.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class CoreRune: SKSpriteNode, Rune {
    private(set) var augments: [Rune] = []
    
    var level: Int = 1
//    let attackSpeed = RuneStatistic(name: "Attack speed", baseValue: 0.625, growthValue: 0.125, rune: self)
//    let range = RuneStatistic(name: "Range", baseValue: 100, growthValue: 2.25, rune: self)
    
    // TODO change to a better way of getting specific runes
    init(typeIndex: Int) {
        let texture = SKTexture(imageNamed: "rune0\(typeIndex).png")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        name = "Core Rune"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
