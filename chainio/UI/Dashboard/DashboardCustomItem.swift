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
    
    private let nameLabel: SKLabelNode = SKLabelNode()
    private let priceLabel: SKLabelNode = SKLabelNode()
    private let structureIcon: SKSpriteNode

    init(structure: Construct.Type) {
        associatedStructure = structure
        let structureInstance = associatedStructure.init()
        price = structureInstance.price

        let iconSize: CGSize = structureInstance.texture?.size() ?? CGSize.zero
        structureIcon = SKSpriteNode(texture: structureInstance.texture, color: UIColor.clear, size: iconSize)

        super.init(texture: nil, color: SKColor.clear, size: CGSize.zero)
        nameLabel.text = structureInstance.name
        priceLabel.text = "\(structureInstance.price)"

        addChild(priceLabel)
        addChild(nameLabel)
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
