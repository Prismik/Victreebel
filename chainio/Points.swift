//
//  Points.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-02.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class Points: SKLabelNode {
    override init() {
        super.init()
    }
    
    init(score: Int) {
        super.init(fontNamed: "HelveticaNeue-Medium")
        self.text = String(score)
        self.fontSize = 14.0
        self.fontColor = UIColor.blue
        self.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func animate() {
        let fadeout: SKAction = SKAction.fadeOut(withDuration: 1)
        let movement: SKAction = SKAction.moveBy(x: 0, y: 15, duration: 1)
        let group: SKAction = SKAction.group([fadeout, movement])
        self.run(group, completion: {
            self.removeFromParent()
        })
    }
}
