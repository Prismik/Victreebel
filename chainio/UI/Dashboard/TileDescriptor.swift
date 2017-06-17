//
//  TileDescriptor.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-17.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class TileDescriptor: SKSpriteNode {
    var tile: Tile? {
        didSet {
            guard let tile = tile else { return }

            tile.actionDelegate = self
            textLabel.text = tile.construct?.name ?? "Empty"
        }
    }
    
    fileprivate let textLabel: SKLabelNode = SKLabelNode(text: "")

    private let margin: CGFloat = 15
    init(size: CGSize) {
        super.init(texture: nil, color: SKColor.orange, size: size)

        anchorPoint = CGPoint(x: 0, y: 0)

        textLabel.position = CGPoint(x: margin, y: margin)
        textLabel.color = UIColor.red
        textLabel.horizontalAlignmentMode = .left
        textLabel.verticalAlignmentMode = .bottom
        addChild(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TileDescriptor: TileActionDelegate {
    func didBuildConstruct() {
        textLabel.text = tile?.construct?.name
    }

    func didRazeConstruct() {
        textLabel.text = "Empty"
    }
}
