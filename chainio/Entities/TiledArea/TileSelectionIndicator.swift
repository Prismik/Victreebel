//
//  TileSelectionIndicator.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-17.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class TileSelectionIndicator: SKSpriteNode {
    private let suroundingIndicator: SKShapeNode
    private let arrowIndicator: SKSpriteNode

    private let animationDuration: TimeInterval = 0.3

    init(size: CGSize) {
        suroundingIndicator = SKShapeNode(rectOf: size + CGSize(width: 3, height: 3))
        suroundingIndicator.strokeColor = UIColor.white
        suroundingIndicator.lineWidth = 3
        suroundingIndicator.zPosition = 100

        let arrowTexture = SKTexture(imageNamed: "arrow")
        arrowIndicator = SKSpriteNode(texture: arrowTexture, color: SKColor.clear, size: arrowTexture.size())
        arrowIndicator.anchorPoint = CGPoint(x: 0.5, y: 0)
        arrowIndicator.zPosition = 102
        super.init(texture: nil, color: SKColor.clear, size: size)
        self.alpha = 0

        addChild(suroundingIndicator)
        addChild(arrowIndicator)

        animateArrow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func animateArrow() {
        let moveUpAction: SKAction = SKAction.move(by: CGVector(dx: 0, dy: 5), duration: animationDuration / 2)
        moveUpAction.timingMode = .easeIn

        let moveDownAction: SKAction = SKAction.move(by: CGVector(dx: 0, dy: -5), duration: animationDuration / 2)
        moveDownAction.timingMode = .easeIn

        let actionSequence: SKAction = SKAction.sequence([moveUpAction, moveDownAction, moveDownAction, moveUpAction])
        arrowIndicator.run(SKAction.repeatForever(actionSequence))
    }

    func show() {
        let fadeInAction: SKAction = SKAction.fadeAlpha(to: 1, duration: animationDuration)

        run(fadeInAction)
    }

    func hide(completion: (() -> Void)?) {
        let fadeOutAction: SKAction = SKAction.fadeAlpha(to: 0, duration: animationDuration)
        
        self.run(fadeOutAction, completion: { [weak self] in
            self?.removeFromParent()
            completion?()
        })
    }
}
