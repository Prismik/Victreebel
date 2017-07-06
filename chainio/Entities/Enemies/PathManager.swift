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
}
