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
    fileprivate var tileSize: CGSize = CGSize.zero
    private var drawableFrameSize: CGSize = CGSize.zero

    weak var delegate: TileSelectionDelegate?

    private let spawner: EnemySpawner = EnemySpawner()
    init(desiredSize: CGSize, horizontalTileCount: Int, verticalTileCount: Int) {
        self.horizontalTileCount = horizontalTileCount
        self.verticalTileCount = verticalTileCount
        super.init(texture: nil, color: SKColor.red, size: desiredSize)

        computeSizesToFit()
        physicsBody = nil
        anchorPoint = CGPoint(x: 0, y: 0)
        let numberOfTiles = horizontalTileCount * verticalTileCount
        let startingZIndex: CGFloat = 100
        for index in 0..<numberOfTiles {
            let tile: Tile = Tile(size: tileSize, type: TileTypes.selectable)
            tile.zPosition = CGFloat(numberOfTiles / 10) + startingZIndex - CGFloat(index / 10)
            tile.color = SKColor(r: index, g: index / 2, b: 2 * index)
            tile.selectionDelegate = self
            addTile(tile, at: positionFromIndex(index))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSpawner() {
        let pathTiles: [Tile] = [
            tileAt(x: horizontalTileCount - 1, y: verticalTileCount - 1)!,
            tileAt(x: horizontalTileCount - 2, y: verticalTileCount - 1)!,
            tileAt(x: horizontalTileCount - 3, y: verticalTileCount - 1)!,
            tileAt(x: horizontalTileCount - 4, y: verticalTileCount - 1)!,
            tileAt(x: horizontalTileCount - 4, y: verticalTileCount - 2)!,
            tileAt(x: horizontalTileCount - 4, y: verticalTileCount - 3)!,
            tileAt(x: horizontalTileCount - 5, y: verticalTileCount - 3)!,
        ]

        if scene != nil {
            let firstTile: Tile = pathTiles.first!
            // TODO Position not working because of anchor point
            spawner.position = firstTile.position //scene.convert(firstTile.position, from: firstTile)
//            spawner.path = pathTiles.map({ tile in scene.convert(tile.position, from: tile) })
            spawner.path = pathTiles.map({ tile in tile.position })
        }

        spawner.activate()
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
        let width = self.width / CGFloat(horizontalTileCount)
        let height = self.height / CGFloat(verticalTileCount)
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
        return gridPositionFromIndex(index) * idealTileSize().width + startingPoint
    }

    private func gridPositionFromIndex(_ index: Int) -> CGPoint {
        let x: Int = index % horizontalTileCount
        let y: Int = Int(floor(Double(index) / Double(horizontalTileCount)))
        return CGPoint(x: x, y: y)
    }

    private func tileExistsAt(x: Int, y: Int) -> Bool {
        return x >= 0 && x < horizontalTileCount && y >= 0 && y < verticalTileCount
    }

    private func tileAt(x: Int, y: Int) -> Tile? {
        if !tileExistsAt(x: x, y: y) {
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
        tile.selectionIndicator = TileSelectionIndicator(size: tileSize, tileZPosition: tile.zPosition)
    }
}
