//
//  DashboardCustomItem.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class DashboardCustomItem: SKSpriteNode {
    let price: Int
    let associatedStructure: Construct.Type
    
    init(price: Int, structure: Construct.Type) {
        self.price = price
        self.associatedStructure = structure
        super.init(texture: nil, color: SKColor.clear, size: CGSize.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
