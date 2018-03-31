//
//  LesserRune.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-03-30.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

// Bonuses in percentage, which can be applied to a core rune statistic values
class LesserRune: Rune {
    var name: String {
        return "Lesser Rune"
    }
    
    var texture: SKTexture {
        fatalError("texture has not been implemented")
    }

    let attackSpeedBonus: Double
    let rangeBonus: Double
    init(attackSpeedBonus: Double, rangeBonus: Double) {
        self.attackSpeedBonus = attackSpeedBonus
        self.rangeBonus = rangeBonus
    }
}
