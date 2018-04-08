//
//  InventoryTile.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-04-07.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class InventoryTile: SKSpriteNode {
    init(size: CGSize) {
        super.init(texture: nil, color: Palette.jagger, size: size)
        
        isUserInteractionEnabled = true
        anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
