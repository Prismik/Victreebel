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
    private let buildableConstructsList: DashboardCustomItemList

    fileprivate var selectedTile: Tile?
    init(size: CGSize) {
        buildableConstructsList = DashboardCustomItemList(size: size)
        super.init(texture: nil, color: SKColor.clear, size: size)

        buildableConstructsList.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {

    }

    
}

extension Dashboard: TileSelectionDelegate {
    func didSelect(tile: Tile) {
        selectedTile = tile
    }
}

extension Dashboard: CustomItemListDelegate {
    func didSelectItem(_ item: DashboardCustomItem) {
        if GameProperties.funds >= item.price {
            selectedTile?.build(entity: item.associatedStructure)
        }

    }
}
