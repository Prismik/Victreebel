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

    var coinLabel: SKLabelNode = SKLabelNode(text: "\(GameProperties.funds)")
    var lifeLabel: SKLabelNode = SKLabelNode(text: "\(GameProperties.life)")
    var scoreLabel: SKLabelNode = SKLabelNode(text: "\(GameProperties.score)")

    var settingsButton: Button!

    private let collisionManager: CollisionManager = CollisionManager()

    private let playAreaHeightPercentage: CGFloat = 0.8
    private let verticalMargin: CGFloat = 10
    private let horizontalMargin: CGFloat = 30
    private let labelContainerHeight: CGFloat = 24
    private let containerColor: SKColor = SKColor(r: 21, g: 21, b: 21, a: 0.6)

    override func didMove(to view: SKView) {
        GameProperties.subscribe(self)
        backgroundColor = SKColor.black

        let lifeContainer = configure(label: lifeLabel, with: CGSize(width: 50, height: labelContainerHeight), using: "heart.png", backgroundColor: containerColor)
        lifeContainer.position = CGPoint(x: 20, y: size.height - 40)

        let coinContainer = configure(label: coinLabel, with: CGSize(width: 70, height: labelContainerHeight), using: "coins.png", backgroundColor: containerColor)
        coinContainer.setPosition(at: .rightAlignTop, margins: UIEdgeInsets.margins(left: horizontalMargin), relativeTo: lifeContainer)

        let scoreContainer = configure(label: scoreLabel, with: CGSize(width: coinContainer.maxX - lifeContainer.minX, height: labelContainerHeight), using: "coins.png", backgroundColor: containerColor)
        scoreContainer.setPosition(at: .underAlignLeft, margins: UIEdgeInsets.margins(top: verticalMargin), relativeTo: lifeContainer)

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

        settingsButton = Button(defaultTexture: SKTexture(imageNamed: "normal.png"),
                                disabledTexture: SKTexture(imageNamed: "disabled.png"),
                                selectedTexture: SKTexture(imageNamed: "pressed.png"))
        settingsButton.position = CGPoint(x: size.width - settingsButton.width / 2, y: size.height - settingsButton.height / 2)
        settingsButton.setAction(action: {

        })
        settingsButton.zPosition = 99999
        addChild(settingsButton)

        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = collisionManager

        ProjectileManager.scene = self
        EnemyManager.scene = self
    }

    override func update(_ currentTime: TimeInterval) {
        ProjectileManager.update(currentTime)
        EnemyManager.update(currentTime)
    }

    private func configure(label: SKLabelNode, with size: CGSize, using imageName: String, backgroundColor: SKColor) -> SKNode {
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        label.fontSize = size.height - 6
        label.zPosition = 999999

        let backgroundNode: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 1.5)
        backgroundNode.fillColor = backgroundColor
        backgroundNode.strokeColor = .clear
        backgroundNode.zPosition = label.zPosition - 0.1
        addChild(backgroundNode)

        let texture = SKTexture(imageNamed: imageName)
        let imageNode: SKSpriteNode = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
        imageNode.zPosition = label.zPosition + 0.1
        backgroundNode.addChild(imageNode)
        imageNode.position = CGPoint(x: 0, y: size.height / 2)

        label.position = CGPoint(x: imageNode.width / 2 + 10, y: size.height / 2)
        backgroundNode.addChild(label)

        return backgroundNode
    }
}

extension GameScene: GamePropertiesObserver {
    func gamePropertiesDidChange() {
        coinLabel.text = "\(GameProperties.funds)"
        lifeLabel.text = "\(GameProperties.life)"
    }
}
