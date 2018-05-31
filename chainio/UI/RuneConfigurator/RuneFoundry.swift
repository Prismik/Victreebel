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

    func process(rune: CoreRune?, in scene: SKScene) {
        guard let currentRune = rune ?? coreRunes.first else { return }
        
        animate(in: scene, shown: !shown, completion: {
            currentRune.alpha = 0
            self.backgroundNode?.addChild(currentRune)
            currentRune.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
        })
    }
    
    private func animate(in scene: SKScene, shown: Bool, completion: @escaping () -> Void) {
        let width: CGFloat = shown ? 125 : 0
        let action = SKAction.resize(toWidth: width, height: width, duration: 0.3)
        if shown {
            let backgroundNode = SKSpriteNode(color: .cyan, size: .zero)
            backgroundNode.zPosition = LayerManager.ui
            self.backgroundNode = backgroundNode
            backgroundNode.position = scene.center
            scene.addChild(backgroundNode)
            backgroundNode.run(action, completion: {
                completion()
            })
        } else {
            backgroundNode?.removeAllChildren()
            backgroundNode?.run(action, completion: {
                self.backgroundNode?.removeFromParent()
            })
        }
    }
    
    private func apply() {
        
    }
}
