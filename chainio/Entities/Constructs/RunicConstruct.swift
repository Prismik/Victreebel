//
//  RunicConstruct.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-03-30.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class RunicConstruct: SKSpriteNode {
    static let texture: SKTexture = SKTexture(imageNamed: "arrowTower")
    
    var sockets: [Socket] = [Socket(central: true)]

    init(secondarySocketsCount: Int) {
        self.sockets += Array(repeating: Socket(central: false), count: secondarySocketsCount)
        
        let texture = RunicConstruct.texture
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        anchorPoint = CGPoint(x: 0.5, y: 0)
        name = "Runic construct"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
