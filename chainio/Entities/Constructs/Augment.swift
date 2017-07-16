//
//  Augment.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-04.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

protocol AugmentDelegate: class {
    var absolutePotition: CGPoint { get }
    func playSound()
}
