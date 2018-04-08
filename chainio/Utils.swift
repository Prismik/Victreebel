//
//  Utils.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-04.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class Utils {
    class func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    class func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}

extension SKColor {
    convenience init(r red: Int, g green: Int, b blue: Int) {
        self.init(r: red, g: green, b: blue, a: 1)
    }

    convenience init(r red: Int, g green: Int, b blue: Int, a alpha: CGFloat) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}

extension BinaryInteger {
    func times(_ closure: () -> Void) {
        var copy = self
        while copy > 0 {
            closure()
            copy -= 1
        }
    }
}
