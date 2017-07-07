//
//  Element.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-06.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation

class Element {
    let resistances: [Element.Type]
    let weaknesses: [Element.Type]

    fileprivate init(resistances: [Element.Type], weaknesses: [Element.Type]) {
        self.resistances = resistances
        self.weaknesses = weaknesses
    }

    func effectMultiplier(for elements: [Element.Type]) -> Double {
        return elements.reduce(1, { (multiplier: Double, element) in
            let weakness: Double = (weaknesses.contains(where: { $0 == element })) ? 2 : 1
            let resistance: Double = (resistances.contains(where: { $0 == element })) ? 0.5 : 1
            return multiplier * weakness * resistance
        })
    }

    func effect() {
        // Compute chance that effect occurs
        // On success, apply
    }
}

class Fire: Element {
    init() {
        super.init(resistances: [Fire.self], weaknesses: [Water.self])
    }
}

class Earth: Element {
    init() {
        super.init(resistances: [Thunder.self, Earth.self], weaknesses: [Water.self])
    }
}

class Thunder: Element {
    init() {
        super.init(resistances: [Water.self, Thunder.self], weaknesses: [])
    }
}

class Water: Element {
    init() {
        super.init(resistances: [Fire.self, Water.self], weaknesses: [Thunder.self])
    }
}
