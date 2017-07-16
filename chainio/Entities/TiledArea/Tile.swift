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
                indicator.position = CGPoint(x: width / 2, y: height / 2)
                addChild(indicator)
            }
        }
    }

    init(size: CGSize, type: UInt32) {
        super.init(texture: nil, color: SKColor.clear, size: size)

        anchorPoint = CGPoint.zero
        physicsBody = nil
        isUserInteractionEnabled = true
        tileDescriptorFlags |= type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouchTarget = true

        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTouchTarget {
            handleSelection()
        }

        isTouchTarget = false

        super.touchesEnded(touches, with: event)
    }

    private func handleSelection() {
        if tileDescriptorFlags & TileTypes.selectable != 0 {
            select()
            if scene != nil {
                let controller: RadialMenuController = RadialMenuController()
                controller.present(from: self, at: CGPoint(x: width / 2, y: height / 2), with: [
                    RadialMenuNode(texture: "arrows", action: {
                        self.build(entity: ArrowTower.self)
                    }),
                    RadialMenuNode(texture: "sword", action: {
                        self.build(entity: ArrowTower.self)
                    }),
                    RadialMenuNode(texture: "spell", action: {
                        self.build(entity: MagicTower.self)
                    }),
                    RadialMenuNode(texture: "wall", action: {
                        self.build(entity: ArrowTower.self)
                    })
                ])
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
        construct?.zPosition = zPosition + 0.02
        addChild(construct!)
        construct?.position = CGPoint(x: width / 2, y: 0)
        construct?.enableAugment()
        actionDelegate?.didBuildConstruct()
        tileDescriptorFlags &= ~TileTypes.buildable
    }

    func raze() {
        construct?.removeFromParent()
        construct = nil
        actionDelegate?.didRazeConstruct()
        tileDescriptorFlags |= TileTypes.buildable
    }
}
