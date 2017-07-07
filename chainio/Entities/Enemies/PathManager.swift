//
//  PathManager.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-05.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class PathManager {
    class func createPath(using points: [CGPoint], with interval: TimeInterval) -> SKAction {
        let timeBetweenPoint: TimeInterval = interval / Double(points.count)
        let moveActions: [SKAction] = points.map({ point in SKAction.move(to: point, duration: timeBetweenPoint) })
        return SKAction.sequence(moveActions)
    }

    class func createBezierPath(using points: [CGPoint], with interval: TimeInterval) -> SKAction {
        var copy: [CGPoint] = points
        let cgPath: CGMutablePath = CGMutablePath()
        cgPath.move(to: copy.removeFirst())
        cgPath.addLines(between: copy)

        return SKAction.follow(cgPath, asOffset: false, orientToPath: false, duration: interval)
    }
}
