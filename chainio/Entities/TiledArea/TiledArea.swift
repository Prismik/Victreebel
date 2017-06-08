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

    init(desiredSize: CGSize, horizontalTileCount: Int, verticalTileCount: Int) {
        self.horizontalTileCount = horizontalTileCount
        self.verticalTileCount = verticalTileCount
        super.init(texture: nil, color: UIColor.clear, size: desiredSize)

        let idealTileSize = self.idealTileSizeWithin(size: desiredSize)
        let numberOfTiles = horizontalTileCount * verticalTileCount
        for index in 0...numberOfTiles {
            self.addTile(Tile(size: idealTileSize), at: self.positionFromIndex(index))
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

    private func idealTileSizeWithin(size: CGSize) -> CGSize {
        let width = size.width / CGFloat(self.horizontalTileCount)
        let height = size.height / CGFloat(self.verticalTileCount)
        let idealUniformLength = min(width, height)
        return CGSize(width: idealUniformLength, height: idealUniformLength)
    }

    private func idealFrameSizeWithin(size: CGSize) -> CGSize {
        let idealTileSize = self.idealTileSizeWithin(size: size)
        return CGSize(width: idealTileSize.width * CGFloat(self.horizontalTileCount),
                      height: idealTileSize.height * CGFloat(self.verticalTileCount))
    }

    private func positionFromIndex(_ index: Int) -> CGPoint {
        return self.gridPositionFromIndex(index) * idealTileSizeWithin(size: size).width
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
        currentSelectedTile?.unselect()
        currentSelectedTile = tile
    }
}
