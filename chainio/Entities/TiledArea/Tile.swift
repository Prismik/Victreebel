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
    private(set) var construct: Construct?

    private var isTouchTarget: Bool = false

    weak var delegate: TileSelectionDelegate?

    var selectionIndicator: SKShapeNode? {
        didSet {
            if let indicator = selectionIndicator {
                addChild(indicator)
            }
        }
    }

    init(size: CGSize, type: UInt32) {
        super.init(texture: nil, color: SKColor.clear, size: size)

        physicsBody = nil
        isUserInteractionEnabled = true
        tileDescriptorFlags |= type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouchTarget = true
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTouchTarget {
            handleSelection()
        }

        isTouchTarget = false
    }

    private func handleSelection() {
        if tileDescriptorFlags & TileTypes.selectable != 0 {
            select()
            if let scene = scene {
                // Present modal from scene OR have a modal controller present it OR populate dashboard with info
                // 
                // Dashboard [ info | categories vert scroll | horiz scrollable buildItems or empty ... | actions ]
            }
        }
    }

    func select() {
        delegate?.didSelect(tile: self)
        selectionIndicator?.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
    }

    func unselect() {
        selectionIndicator?.run(SKAction.fadeAlpha(to: 0, duration: 0.3), completion: { [weak self] in
            self?.selectionIndicator?.removeFromParent()
        })
    }

    func build(entity: Construct.Type) {
        // build the thing
        tileDescriptorFlags &= ~TileTypes.buildable
    }

    func raze() {
        // raze the thing
        tileDescriptorFlags |= TileTypes.buildable
    }
}
