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

protocol TileActionDelegate: class {
    func didBuildConstruct()
    func didRazeConstruct()
}

// TODO How to have multiples tiles binded together to hold a bigger entity
class Tile: SKSpriteNode {
    private(set) var tileDescriptorFlags: UInt32 = TileTypes.none
    private(set) var construct: Construct?

    private var isTouchTarget: Bool = false

    weak var selectionDelegate: TileSelectionDelegate?
    weak var actionDelegate: TileActionDelegate?

    var selectionIndicator: TileSelectionIndicator? {
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
        selectionDelegate?.didSelect(tile: self)
        selectionIndicator?.show()
    }

    func unselect() {
        selectionIndicator?.hide(completion: { [weak self] in
            self?.selectionIndicator = nil
        })
    }

    func build(entity: Construct.Type) {
        construct = entity.init()
        actionDelegate?.didBuildConstruct()
        tileDescriptorFlags &= ~TileTypes.buildable
    }

    func raze() {
        // raze the thing
        actionDelegate?.didRazeConstruct()
        tileDescriptorFlags |= TileTypes.buildable
    }
}
