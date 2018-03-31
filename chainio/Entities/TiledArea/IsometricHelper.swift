//
//  IsometricHelper.swift
//  chainio
//
//  Created by Francis Beauch on 2017-11-04.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class IsometricHelper {
    private let tileSize: CGSize
    private let initialPoint: CGPoint
    init(tileSize: CGSize, initialPoint: CGPoint) {
        self.tileSize = tileSize
        self.initialPoint = initialPoint
    }

    func convertToIsometric(gridPoint: CGPoint) -> CGPoint {
        let isometricX = (gridPoint.y + gridPoint.x) * tileSize.width / 2
        let isometricY = (gridPoint.y - gridPoint.x) * tileSize.height / 2
        return CGPoint(x: initialPoint.x + isometricX, y: initialPoint.y + isometricY)
    }

    // redo
    func convertToCartesian(isometricPoint: CGPoint) -> CGPoint {
        let cartesianX = (isometricPoint.x / tileSize.width / 2 + isometricPoint.y / tileSize.height / 2) / 2
        let cartesianY = (isometricPoint.y / tileSize.height / 2 - (isometricPoint.x / tileSize.width / 2)) / 2
        return CGPoint(x: cartesianX, y: cartesianY)
    }
}
