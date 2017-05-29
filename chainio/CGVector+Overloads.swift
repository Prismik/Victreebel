//
//  CGVector+Overloads.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-05-28.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import CoreGraphics
import SpriteKit

public extension CGVector {
    public func length() -> CGFloat {
        return sqrt(dx * dx + dy * dy)
    }

    public func lengthSquared() -> CGFloat {
        return dx * dx + dy * dy
    }

    /**
     * Normalizes the vector described by the CGVector to length 1.0 and returns
     * the result as a new CGVector.
     */
    func normalized() -> CGVector {
        let len = length()
        return len>0 ? self / len : CGVector.zero
    }

    /// Normalizes the vector described by the CGVector to length 1.0.
    public mutating func normalize() -> CGVector {
        self = normalized()
        return self
    }

    /**
     * Calculates the distance between two CGVectors. Pythagoras!
     */
    public func distanceTo(_ vector: CGVector) -> CGFloat {
        return (self - vector).length()
    }

    /**
     * Returns the angle in radians of the vector described by the CGVector.
     * The range of the angle is -π to π; an angle of 0 points to the right.
     */
    public var angle: CGFloat {
        return atan2(dy, dx)
    }
}

public func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}

public func += (left: inout CGVector, right: CGVector) {
    left = left + right
}

public func - (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

public func -= (left: inout CGVector, right: CGVector) {
    left = left - right
}

public func * (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx * right.dx, dy: left.dy * right.dy)
}

public func *= (left: inout CGVector, right: CGVector) {
    left = left * right
}

public func * (vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
}

public func *= (vector: inout CGVector, scalar: CGFloat) {
    vector = vector * scalar
}

public func / (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx / right.dx, dy: left.dy / right.dy)
}

public func /= (left: inout CGVector, right: CGVector) {
    left = left / right
}

public func / (vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
}

public func /= (vector: inout CGVector, scalar: CGFloat) {
    vector = vector / scalar
}
