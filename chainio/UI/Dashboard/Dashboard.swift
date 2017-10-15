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
    fileprivate let selectedTileDescriptor: TileDescriptor

    fileprivate var selectedTile: Tile?
    init(size: CGSize) {
        let constructListSize: CGSize = CGSize(width: size.width * 0.8, height: size.height)
        let selectedTileDescriptorSize: CGSize = CGSize(width: size.width * 0.2, height: size.height)

        selectedTileDescriptor = TileDescriptor(size: selectedTileDescriptorSize)
        selectedTileDescriptor.position = CGPoint.zero

        super.init(texture: nil, color: SKColor.clear, size: size)

        isUserInteractionEnabled = true
        anchorPoint = CGPoint(x: 0, y: 0)

        addChild(selectedTileDescriptor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {

    }

    func show() {
        if isHidden {
            isHidden = false
            run(SKAction.moveBy(x: 0, y: height, duration: 0.3))
        }
    }

    func hide() {
        if !isHidden {
            run(SKAction.moveBy(x: 0, y: -height, duration: 0.3), completion: { [weak self] in
                self?.isHidden = true
            })
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hide()

        super.touchesEnded(touches, with: event)
    }
}

extension Dashboard: TileSelectionDelegate {
    func didSelect(tile: Tile) {
        show()
        selectedTile = tile
        selectedTileDescriptor.tile = tile
    }
}
