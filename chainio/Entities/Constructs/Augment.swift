//
//  Augment.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-04.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

protocol AugmentDelegate: class {
    func getPosition() -> CGPoint
    func play(sound named: String)
}
