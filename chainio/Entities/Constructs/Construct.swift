//
//  Construct.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

// Structure to which we can attach runes to enable various effects
protocol Construct: class {
    var price: Int { get } // Deprecate this
    static var uiTexture: SKTexture { get }
    func enableAugment() // Deprecate this
    func availableUpgrades() -> [Construct.Type] // Deprecate this ?
}
