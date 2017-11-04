//
//  ModalDialogNode.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-08-26.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

protocol ModalNodeDelegate: class {
    func didOpen()
    func didClose()
    func willOpen()
    func willClose()
}

class ModalNode: SKSpriteNode {
    func present() {

    }

    func dismiss() {
        
    }
}
