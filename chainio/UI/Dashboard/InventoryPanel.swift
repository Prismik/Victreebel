//
//  InventoryPanel.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-04-07.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class InventoryPanel: SKSpriteNode {
    enum State {
        case open
        case closed
    }

    private let handle: InventoryHandle
    private let inventorySize = 8

    private let openSize: CGSize
    private(set) var state: State = .closed {
        didSet {
            animateStateChange()
        }
    }
    
    init(size: CGSize) {
        self.openSize = size
        self.handle = InventoryHandle(texture: nil, color: Palette.royalBlue, size: CGSize(width: 15, height: 15))
        super.init(texture: nil, color: Palette.jagger, size: CGSize(width: size.width, height: size.height))
        
        initializeTiles()

        anchorPoint = CGPoint(x: 0, y: 0)
        isUserInteractionEnabled = true
        
        handle.isUserInteractionEnabled = true
        handle.zPosition = LayerManager.ui + 1
        handle.setPosition(at: .underAlignLeft, margins: .margins(left: width / 2), relativeTo: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeTiles() {
        let tileSize = CGSize(width: width / CGFloat(inventorySize), height: height)
        inventorySize.times {
            let tile = InventoryTile(size: tileSize)
            addChild(tile)
        }
    }
    
    private func animateStateChange() {
        let dy = state == .open ? height : -height
        let action = SKAction.moveBy(x: 0, y: dy, duration: 0.5)
        action.timingMode = .easeOut
        run(action)
    }
}

extension InventoryPanel: InventoryHandleDelegate {
    func didTouchHandle() {
        state = state == .closed ? .open : .closed
    }
}

protocol InventoryHandleDelegate: class {
    func didTouchHandle()
}

class InventoryHandle: SKSpriteNode {
    weak var delegate: InventoryHandleDelegate?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        delegate?.didTouchHandle()
    }
}
