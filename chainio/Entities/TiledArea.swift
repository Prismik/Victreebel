//
//  TiledArea.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-08.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class TiledArea {
    private var tiles: [Tile] = []

    private let horizontalTileCount: Int
    private let verticalTileCount: Int

    private(set) var frame: CGRect = CGRect.zero
    init(frame: CGRect, horizontalTileCount: Int, verticalTileCount: Int) {
        self.horizontalTileCount = horizontalTileCount
        self.verticalTileCount = verticalTileCount
        self.frame = idealFrameSizeWithin(frame: frame)
    }

    func setPassablePath(tilesLocation: [CGPoint]) {

    }

    private func idealTileSizeWithin(frame: CGRect) -> CGSize {
        let width = frame.width / CGFloat(self.horizontalTileCount)
        let height = frame.height / CGFloat(self.verticalTileCount)
        let idealUniformLength = min(width, height)
        return CGSize(width: idealUniformLength, height: idealUniformLength)
    }

    private func idealFrameSizeWithin(frame: CGRect) -> CGRect {
        let idealTileSize = self.idealTileSizeWithin(frame: frame)
        return CGRect(x: frame.minX,
                      y: frame.minY,
                      width: idealTileSize.width * CGFloat(self.horizontalTileCount),
                      height: idealTileSize.height * CGFloat(self.verticalTileCount))
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
