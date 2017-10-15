//
//  Construct.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

protocol Construct: class {
    var price: Int { get }
    static var uiTexture: SKTexture { get }
    func enableAugment()
    func availableUpgrades() -> [Construct.Type]
}
