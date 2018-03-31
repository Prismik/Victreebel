//
//  CoreRune.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-03-30.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class CoreRune: Rune {
    var name: String {
        return "Core Rune"
    }
    
    var texture: SKTexture {
        fatalError("texture has not been implemented")
    }

    var augments: [Rune] = []
    
    var level: Int = 1
//    let attackSpeed = RuneStatistic(name: "Attack speed", baseValue: 0.625, growthValue: 0.125, rune: self)
//    let range = RuneStatistic(name: "Range", baseValue: 100, growthValue: 2.25, rune: self)
    
    init() {
        
    }
}
