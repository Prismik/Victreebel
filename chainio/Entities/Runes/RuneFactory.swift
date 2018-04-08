//
//  RuneFactory.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-04-07.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation

class RuneFactory {
    class func craftRune() -> LesserRune {
        let ias = 0.15 + Double(arc4random_uniform(3))
        let range = 50 + Double(arc4random_uniform(150))
        return LesserRune(attackSpeedBonus: ias, rangeBonus: range)
    }
}
