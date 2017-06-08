//
//  Tile.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-08.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

protocol TileSelectionDelegate: class {
    func didSelect(tile: Tile)
}

// TODO How to have multiples tiles binded together to hold a bigger entity
class Tile: SKSpriteNode {
    private(set) var tileDescriptorFlags: UInt32 = TileTypes.none

    private var isTouchTarget: Bool = false
    private let selectionIndicator: SKSpriteNode = SKSpriteNode()

    weak var delegate: TileSelectionDelegate?

    init(size: CGSize) {
        super.init(texture: nil, color: SKColor.clear, size: size)

        selectionIndicator.alpha = 0
        addChild(selectionIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouchTarget = true
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isTouchTarget {
            self.handleSelection()
        }

        self.isTouchTarget = false
    }

    private func handleSelection() {
        if tileDescriptorFlags & TileTypes.selectable != 0 {
            self.select()
            if let scene = self.scene {
                // Present modal from scene OR have a modal controller present it OR populate dashboard with info
                // 
                // Dashboard [ info | categories vert scroll | horiz scrollable buildItems or empty ... | actions ]
            }
        }
    }

    func select() {
        selectionIndicator.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
        delegate?.didSelect(tile: self)
    }

    func unselect() {
        selectionIndicator.run(SKAction.fadeAlpha(to: 0, duration: 0.3))
    }

    func build(entity: SKSpriteNode.Type) {
        // build the thing
        self.tileDescriptorFlags &= ~TileTypes.buildable
    }

    func raze() {
        // raze the thing
        self.tileDescriptorFlags |= TileTypes.buildable
    }
}
