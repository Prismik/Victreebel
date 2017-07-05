//
//  CustomItemList.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

protocol CustomItemListDelegate: class {
    func didSelectItem(_ item: DashboardCustomItem)
}

class DashboardCustomItemList: SKSpriteNode {
    weak var delegate: CustomItemListDelegate?

    private var items: [DashboardCustomItem] = []

    private let horizontalMargin: CGFloat = 10
    private let verticalMargin: CGFloat = 10

    init(size: CGSize) {
        super.init(texture: nil, color: SKColor.brown, size: size)

        let itemSize: CGSize = CGSize(width: (size.width - 7 * horizontalMargin) / 6, height: size.height - 2 * verticalMargin)
        items.append(DashboardCustomItem(structure: ArrowTower.self, size: itemSize))
        items.append(DashboardCustomItem(structure: ArrowTower.self, size: itemSize))
        items.append(DashboardCustomItem(structure: ArrowTower.self, size: itemSize))
        items.append(DashboardCustomItem(structure: ArrowTower.self, size: itemSize))
        items.append(DashboardCustomItem(structure: ArrowTower.self, size: itemSize))
        items.append(DashboardCustomItem(structure: ArrowTower.self, size: itemSize))

        for index in 0..<items.count {
            let x: CGFloat = itemSize.width * CGFloat(index) + CGFloat(index + 1) * horizontalMargin
            items[index].position = CGPoint(x: x, y: verticalMargin)
            items[index].delegate = self
            addChild(items[index])
        }

        anchorPoint = CGPoint(x: 0, y: 0)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DashboardCustomItemList: CustomItemDelegate {
    func didSelectItem(_ item: DashboardCustomItem) {
        delegate?.didSelectItem(item)
    }
}
