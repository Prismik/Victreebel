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

    var coinLabel: SKLabelNode!

    private let collisionManager: CollisionManager = CollisionManager()
    private let playAreaHeightPercentage: CGFloat = 0.8

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black

        coinLabel = SKLabelNode(text: "\(GameProperties.funds)")
        configure(label: coinLabel, at: CGPoint(x: 20, y: size.height - 40), with: CGSize(width: 120, height: 24), using: "coins.png", backgroundColor: SKColor(r: 21, g: 21, b: 21, a: 0.6))

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

    private func configure(label: SKLabelNode, at position: CGPoint, with size: CGSize, using imageName: String, backgroundColor: SKColor) {
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        label.fontSize = size.height - 6
        label.zPosition = 999999

        let backgroundNode: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 1.5)
        backgroundNode.fillColor = backgroundColor
        backgroundNode.strokeColor = .clear
        backgroundNode.zPosition = label.zPosition - 0.1
        backgroundNode.position = position
        addChild(backgroundNode)

        let texture = SKTexture(imageNamed: imageName)
        let imageNode: SKSpriteNode = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
        imageNode.zPosition = label.zPosition + 0.1
        backgroundNode.addChild(imageNode)
        imageNode.position = CGPoint(x: 0, y: size.height / 2)

        label.position = CGPoint(x: imageNode.width + 15, y: size.height / 2)
        backgroundNode.addChild(label)
    }
}

extension GameScene: GamePropertiesObserver {
    func gamePropertiesDidChange() {
        coinLabel.text = "\(GameProperties.funds)"
    }
}
