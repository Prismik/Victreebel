//
//  RuneFoundry.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-05-31.
//  Copyright 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class RuneFoundry {
    private var coreRunes: [CoreRune] = []
    private var lesserRunes: [LesserRune] = []
    
    private var backgroundNode: SKSpriteNode?

    private var shown: Bool = false

    private let coreSize = CGSize(width: 90, height: 90)

    init() {
        
    }

    func process(rune: CoreRune?, in scene: SKScene) {
        guard let currentRune = rune ?? coreRunes.first else { return }
        
        show(in: scene, completion: {
            guard let backgroundNode = self.backgroundNode else { return }

            let overlayNode = RockOverlay(size: backgroundNode.size)
            overlayNode.position = .zero
            overlayNode.alpha = 0
            backgroundNode.addChild(overlayNode)

            let coreNode = SKSpriteNode(color: Palette.jagger, size: self.coreSize)
            overlayNode.addChild(coreNode)
            
            let texture = SKTexture(imageNamed: "xButton.png")
            let closeButton = Button(defaultTexture: texture, disabledTexture: texture, selectedTexture: texture)
            closeButton.setAction {
                self.hide()
            }
            closeButton.position = CGPoint(x: backgroundNode.width / 2, y: backgroundNode.height / 2)
            overlayNode.addChild(closeButton)
            
            coreNode.addChild(currentRune)

            overlayNode.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
        })
    }
    
    private func show(in scene: SKScene, completion: @escaping () -> Void) {
        let width: CGFloat = scene.width * 0.7
        let height: CGFloat = scene.height * 0.7
        let action = SKAction.resize(toWidth: width, height: height, duration: 0.3)
        let backgroundNode = Sprite(color: Palette.black.withAlphaComponent(0.1), size: .zero)
        backgroundNode.zPosition = LayerManager.ui
//        backgroundNode.touchUpInside {
//            self.hide()
//        }
        self.backgroundNode = backgroundNode
        backgroundNode.position = scene.center
        scene.addChild(backgroundNode)
        backgroundNode.run(action, completion: completion)
    }
    
    private func hide() {
        let actionGroup = SKAction.group([
            SKAction.resize(toWidth: 0, height: 0, duration: 0.3),
            SKAction.fadeAlpha(to: 0, duration: 0.3)
        ])
        backgroundNode?.run(actionGroup, completion: {
            self.didDisappear()
        })
    }

    private func didDisappear() {
        backgroundNode?.removeFromParent()
        backgroundNode?.removeAllChildren(recursive: true)
        backgroundNode = nil
    }

    private func apply() {
        
    }
}
