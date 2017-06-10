//
//  Dashboard.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-13.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class Dashboard: SKSpriteNode {
    init(size: CGSize) {
        super.init(texture: nil, color: SKColor.clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Dashboard: TileSelectionDelegate {
    func didSelect(tile: Tile) {
        // cool
    }
}
