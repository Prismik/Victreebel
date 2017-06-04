//
//  MathExtensions.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-05-27.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

extension ClosedRange {
    func clamp(value : Bound) -> Bound {
        return self.lowerBound > value ? self.lowerBound
            : self.upperBound < value ? self.upperBound
            : value
    }
}
