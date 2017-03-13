//
//  SKAction+CustomActions.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-13.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit
extension SKAction {
    static func oscillation(amplitude a: CGFloat, timePeriod t: Double, midPoint: CGPoint) -> SKAction {
        let action = SKAction.customAction(withDuration: t) { node, currentTime in
            let displacement = a * sin(2 * CGFloat.pi * currentTime / CGFloat(t))
            node.position.y = midPoint.y + displacement
        }
        
        return action
    }
}
