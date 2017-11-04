//
//  ModalNodeController.swift
//  chainio
//
//  Created by Francis Beauch on 2017-10-07.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class ModalNodeController {
    fileprivate var onOpen: (() -> Void)?
    fileprivate var onClose: (() -> Void)?
    private let modal: ModalNode = ModalNode()
    init() {

    }

    func dismiss(completion: (() -> Void)? = nil) {
        onClose = completion
//        modal.close()
    }

    func present(from node: SKNode, at position: CGPoint, completion: (() -> Void)? = nil) {
        onOpen = completion
        modal.position = position
//        modal.nodes = options.map({ datum in RadialmodalNode(texture: datum.texture, action: datum.action) })
//        node.addChild(modal)
//        modal.show()
    }
}
