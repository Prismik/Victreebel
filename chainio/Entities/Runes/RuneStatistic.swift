//
//  RuneStatistic.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-03-30.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation


// Will define base values for major behaviours of a structure, such as attack speed, attack trajectory, on hit
// A rune will be able to grow, along with a list of attached lesser runes
class RuneStatistic {
    unowned let rune: CoreRune
    
    let name: String
    
    private let baseValue: Double
    private let growthValue: Double
    var value: Double {
        let levelUps: Double = Double(rune.level) - 1
        return baseValue + growthValue * levelUps * (0.7025 + 0.0175 * levelUps)
    }
    
    init(name: String, baseValue: Double, growthValue: Double, rune: CoreRune) {
        self.name = name
        self.baseValue = baseValue
        self.growthValue = growthValue
        self.rune = rune
    }
}
