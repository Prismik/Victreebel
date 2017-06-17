//
//  TiledArea.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-08.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class TiledArea: SKSpriteNode {
    private var tiles: [Tile] = []
    fileprivate var currentSelectedTile: Tile?

    private let horizontalTileCount: Int
    private let verticalTileCount: Int
    private var startingPoint: CGPoint = CGPoint.zero
    private var tileSize: CGSize = CGSize.zero
    private var drawableFrameSize: CGSize = CGSize.zero

    weak var delegate: TileSelectionDelegate?

    init(desiredSize: CGSize, horizontalTileCount: Int, verticalTileCount: Int) {
        self.horizontalTileCount = horizontalTileCount
        self.verticalTileCount = verticalTileCount
        super.init(texture: nil, color: SKColor.red, size: desiredSize)

        computeSizesToFit()
        physicsBody = nil
        anchorPoint = CGPoint(x: 0, y: 0)
        let tileSize = idealTileSize()
        let numberOfTiles = horizontalTileCount * verticalTileCount
        for index in 0..<numberOfTiles {
            let tile: Tile = Tile(size: tileSize, type: TileTypes.selectable)
            tile.color = SKColor(r: index, g: index / 2, b: 2 * index)
            tile.selectionDelegate = self
            self.addTile(tile, at: self.positionFromIndex(index))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPassablePath(tilesLocation: [CGPoint]) {

    }

    private func addTile(_ tile: Tile, at position: CGPoint) {
        tile.position = position
        tiles.append(tile)
        addChild(tile)
    }

    // Order of computation must not change
    private func computeSizesToFit() {
        tileSize = idealTileSize()
        drawableFrameSize = idealFrameSize()
        startingPoint = idealStartingPoint()
    }

    private func idealTileSize() -> CGSize {
        let width = size.width / CGFloat(horizontalTileCount)
        let height = size.height / CGFloat(verticalTileCount)
        let idealUniformLength = min(width, height)
        return CGSize(width: idealUniformLength, height: idealUniformLength)
    }

    private func idealFrameSize() -> CGSize {
        return CGSize(width: tileSize.width * CGFloat(horizontalTileCount),
               height: tileSize.height * CGFloat(verticalTileCount))
    }

    private func idealStartingPoint() -> CGPoint {
        let sizeDifference = size - drawableFrameSize
        return CGPoint(x: sizeDifference.width / 2, y: sizeDifference.height / 2)
    }

    private func positionFromIndex(_ index: Int) -> CGPoint {
        return self.gridPositionFromIndex(index) * idealTileSize().width + startingPoint + CGPoint(x: tileSize.width / 2, y: tileSize.height / 2)
    }

    private func gridPositionFromIndex(_ index: Int) -> CGPoint {
        let x: Int = index % horizontalTileCount
        let y: Int = Int(floor(Double(index) / Double(horizontalTileCount)))
        return CGPoint(x: x, y: y)
    }

    private func tileExistsAt(x: Int, y: Int) -> Bool {
        return x >= 0 && x < self.horizontalTileCount && y >= 0 && y < self.verticalTileCount
    }

    private func tileAt(x: Int, y: Int) -> Tile? {
        if !self.tileExistsAt(x: x, y: y) {
            return nil
        }

        return tiles[x + y * horizontalTileCount]
    }
}

extension TiledArea: TileSelectionDelegate {
    func didSelect(tile: Tile) {
        if tile != currentSelectedTile {
            currentSelectedTile?.unselect()
            currentSelectedTile = tile
            createSelectionIndicatorOnTile(tile)
            delegate?.didSelect(tile: tile)
        }
    }

    private func createSelectionIndicatorOnTile(_ tile: Tile) {
        let selectionIndicator: SKShapeNode = SKShapeNode(rectOf: tile.size + CGSize(width: 3, height: 3))
        selectionIndicator.strokeColor = UIColor.white
        selectionIndicator.lineWidth = 3
        selectionIndicator.alpha = 0
        selectionIndicator.zPosition = 100
        tile.selectionIndicator = selectionIndicator
    }
}
