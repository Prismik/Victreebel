//
//  Construct.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class Construct: SKSpriteNode {
    let price: Int

    init(texture: SKTexture?, price: Int, name: String) {
        self.price = price
        super.init(texture: texture, color: UIColor.clear, size: texture?.size() ?? CGSize.zero)
        self.name = name
        zPosition = 101
        anchorPoint = CGPoint(x: 0.5, y: 0)
    }

    required convenience init() {
        self.init(texture: nil, price: 0, name: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
