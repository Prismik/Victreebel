//
//  RockOverlay.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-06-10.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class RockOverlay: SKSpriteNode {
    private let texturePrefix: String = "mountain_"
    private let tileSize: CGFloat = 32
    private var textures: [SKTexture] = []

    init(size: CGSize) {
        super.init(texture: nil, color: .orange, size: size)

        let numberOfHorizontalTiles: Int = Int(size.width / tileSize)
        let numberOfVerticalTiles: Int = Int(size.height / tileSize)

        let deltaX = width - CGFloat(numberOfHorizontalTiles) * tileSize
        let deltaY = height - CGFloat(numberOfVerticalTiles) * tileSize

        buildTop(tileCount: numberOfHorizontalTiles, deltaX: deltaX, deltaY: deltaY)
        buildBottom(tileCount: numberOfHorizontalTiles, deltaX: deltaX, deltaY: deltaY)
        buildLeft(tileCount: numberOfVerticalTiles, deltaX: deltaX, deltaY: deltaY)
        buildRight(tileCount: numberOfVerticalTiles, deltaX: deltaX, deltaY: deltaY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildTop(tileCount: Int, deltaX: CGFloat, deltaY: CGFloat) {
        
        let topLeft = SKSpriteNode(imageNamed: texturePrefix + "topLeft")
        topLeft.anchorPoint = .zero
        topLeft.position = CGPoint(x: deltaX / 2 - width / 2,
                                   y: height / 2 - tileSize - deltaY / 2)
        addChild(topLeft)
        
        let topRight = SKSpriteNode(imageNamed: texturePrefix + "topRight")
        topRight.anchorPoint = .zero
        topRight.position = CGPoint(x: width / 2 - tileSize - deltaX / 2,
                                    y: height / 2 - tileSize - deltaY / 2)
        addChild(topRight)
        
        for index in 1 ... tileCount - 2 {
            let textureName = index % 2 == 0 ? "topCenterLeft" : "topCenterRight"
            let tile = SKSpriteNode(imageNamed: texturePrefix + textureName)
            tile.anchorPoint = .zero
            tile.position = CGPoint(x: deltaX / 2 - width / 2 + CGFloat(index) * tileSize,
                                    y: height / 2 - tileSize - deltaY / 2)
            addChild(tile)
        }
    }
    
    private func buildBottom(tileCount: Int, deltaX: CGFloat, deltaY: CGFloat) {
        let deltaX = width - CGFloat(tileCount) * tileSize
        let bottomLeft = SKSpriteNode(imageNamed: texturePrefix + "bottomLeft")
        bottomLeft.anchorPoint = .zero
        bottomLeft.position = CGPoint(x: deltaX / 2 - width / 2,
                                      y: -height / 2 + deltaY / 2)
        addChild(bottomLeft)
        
        let bottomRight = SKSpriteNode(imageNamed: texturePrefix + "bottomRight")
        bottomRight.anchorPoint = .zero
        bottomRight.position = CGPoint(x: width / 2 - tileSize - deltaX / 2,
                                       y: -height / 2 + deltaY / 2)
        addChild(bottomRight)
        
        for index in 1 ... tileCount - 2 {
            let textureName = index % 2 == 0 ? "bottomCenterLeft" : "bottomCenterRight"
            let tile = SKSpriteNode(imageNamed: texturePrefix + textureName)
            tile.anchorPoint = .zero
            tile.position = CGPoint(x: deltaX / 2 - width / 2 + CGFloat(index) * tileSize,
                                    y: -height / 2 + deltaY / 2)
            addChild(tile)
        }
    }
    
    private func buildLeft(tileCount: Int, deltaX: CGFloat, deltaY: CGFloat) {
        for index in 1 ... tileCount - 2 {
            let textureName = "left"
            let tile = SKSpriteNode(imageNamed: texturePrefix + textureName)
            tile.anchorPoint = .zero
            tile.position = CGPoint(x: -width / 2 + deltaX / 2,
                                    y: height / 2 - (tileSize + CGFloat(index) * tileSize + deltaY / 2))
            addChild(tile)
        }
    }
    
    private func buildRight(tileCount: Int, deltaX: CGFloat, deltaY: CGFloat) {
        for index in 1 ... tileCount - 2 {
            let textureName = "right"
            let tile = SKSpriteNode(imageNamed: texturePrefix + textureName)
            tile.anchorPoint = .zero
            tile.position = CGPoint(x: width / 2 - tileSize - deltaX / 2,
                                    y: height / 2 - (tileSize + CGFloat(index) * tileSize + deltaY / 2))
            addChild(tile)
        }
    }
    
    private func fillCenter(horizontalTileCount: Int, verticalTileCount: Int, deltaX: CGFloat, deltaY: CGFloat) {
        
    }
}
