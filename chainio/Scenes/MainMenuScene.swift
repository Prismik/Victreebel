//
//  MainMenuScene.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-06.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.blue
        let label = SKLabelNode(text: "Press to start")
        label.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(label)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameplayScene: SKScene = GameScene(size: self.view!.bounds.size)
        let duration: TimeInterval = 2.0
        let flipTransition: SKTransition = SKTransition.push(with: SKTransitionDirection.down, duration: duration)
        self.view!.presentScene(gameplayScene, transition: flipTransition)
    }
}
