//
//  RadialMenuController.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-15.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class RadialMenuController {
    fileprivate var onOpen: (() -> Void)?
    fileprivate var onClose: (() -> Void)?
    private let menu: RadialMenu = RadialMenu(radius: 30, animationDuration: 0.3)
    init() {
        menu.delegate = self
    }

    func dismiss(completion: (() -> Void)? = nil) {
        onClose = completion
        menu.close()
    }

    func present(from node: SKNode, at position: CGPoint, with options: [RadialMenuNodeData], completion: (() -> Void)? = nil) {
        onOpen = completion
        menu.position = position
        menu.nodes = options.map({ datum in RadialMenuNode(texture: datum.texture, action: datum.action) })
        node.addChild(menu)
        menu.show()
    }
}

extension RadialMenuController: RadialMenuDelegate {
    func willOpen() {

    }

    func didOpen() {
        onOpen?()
    }

    func willClose() {

    }

    func didClose() {
        onClose?()
    }
}
