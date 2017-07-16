//
//  RadialMenuController.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-15.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class RadialMenuController {
    init() {

    }

    func present(from node: SKNode, at position: CGPoint, with options: [RadialMenuNode]) {
        let menu: RadialMenu = RadialMenu(radius: 30, animationDuration: 0.3)
        menu.position = position
        menu.nodes = options
        node.addChild(menu)
        menu.show()
    }
}
