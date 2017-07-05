//
//  DashboardCustomItem.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

protocol CustomItemDelegate: class {
    func didSelectItem(_ item: DashboardCustomItem)
}

class DashboardCustomItem: SKSpriteNode {
    let associatedStructure: Construct.Type
    let price: Int

    weak var delegate: CustomItemDelegate?

    private let priceLabel: SKLabelNode = SKLabelNode()
    private let structureIcon: SKSpriteNode

    init(structure: Construct.Type, size: CGSize) {
        associatedStructure = structure
        let structureInstance = associatedStructure.init()
        price = structureInstance.price

        structureIcon = SKSpriteNode(texture: structureInstance.texture, color: UIColor.red, size: size - CGSize(width: 30, height: 10))
        structureIcon.position = CGPoint(x: 0, y: 30)
        super.init(texture: nil, color: SKColor.clear, size: CGSize.zero)
        isUserInteractionEnabled = true

        priceLabel.text = "\(structureInstance.price)"
        priceLabel.color = SKColor.black
        priceLabel.position = CGPoint(x: 0, y: 0)
        priceLabel.fontSize = 12
        priceLabel.verticalAlignmentMode = .bottom
        priceLabel.horizontalAlignmentMode = .center
        addChild(priceLabel)
        addChild(structureIcon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didSelectItem(self)

        super.touchesEnded(touches, with: event)
    }
}
