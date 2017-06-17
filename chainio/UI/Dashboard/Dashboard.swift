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
    fileprivate let selectedTileDescriptor: TileDescriptor

    fileprivate var selectedTile: Tile?
    init(size: CGSize) {
        let constructListSize: CGSize = CGSize(width: size.width * 0.8, height: size.height)
        let selectedTileDescriptorSize: CGSize = CGSize(width: size.width * 0.2, height: size.height)

        selectedTileDescriptor = TileDescriptor(size: selectedTileDescriptorSize)
        selectedTileDescriptor.position = CGPoint.zero
        buildableConstructsList = DashboardCustomItemList(size: constructListSize)
        buildableConstructsList.position = CGPoint(x: selectedTileDescriptorSize.width, y: 0)

        super.init(texture: nil, color: SKColor.clear, size: size)

        anchorPoint = CGPoint(x: 0, y: 0)
        buildableConstructsList.delegate = self

        addChild(selectedTileDescriptor)
        addChild(buildableConstructsList)
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
        selectedTileDescriptor.tile = tile
    }
}

extension Dashboard: CustomItemListDelegate {
    func didSelectItem(_ item: DashboardCustomItem) {
        if GameProperties.funds >= item.price {
            selectedTile?.build(entity: item.associatedStructure)
        }

    }

    func toucheOccured() {
        selectedTile?.build(entity: ArrowTower.self)
    }
}
