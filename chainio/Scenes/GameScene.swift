//
//  GameScene.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-01-20.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var tiledArea: TiledArea!
    var infoArea: Dashboard!

    var coinLabel: LabelWithImage!

    private let collisionManager: CollisionManager = CollisionManager()
    private let playAreaHeightPercentage: CGFloat = 0.8

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black

        coinLabel = LabelWithImage(texture: SKTexture(imageNamed: "coins.png"), size: CGSize(width: 120, height: 24))
        coinLabel.text = "\(GameProperties.funds)"
        coinLabel.zPosition = 999999
        coinLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        coinLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        coinLabel.position = CGPoint(x: 20, y: size.height - 40)
        addChild(coinLabel)

        infoArea = Dashboard(size: CGSize(width: size.width, height: size.height * (1 - playAreaHeightPercentage)))
        infoArea.position = CGPoint(x: 0, y: 0)
        infoArea.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(infoArea)

        tiledArea = TiledArea(desiredSize: CGSize(width: size.width, height: size.height * playAreaHeightPercentage),
                              horizontalTileCount: 16, verticalTileCount: 6)
        tiledArea.position = CGPoint(x: 0, y: size.height * (1 - playAreaHeightPercentage))
        tiledArea.delegate = infoArea
        addChild(tiledArea)
        tiledArea.configureSpawner()

        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = collisionManager

        ProjectileManager.scene = self
        EnemyManager.scene = self
    }

    override func update(_ currentTime: TimeInterval) {
        ProjectileManager.update(currentTime)
        EnemyManager.update(currentTime)
    }
}
