//
//  Player.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-06.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

enum PlayerMovementDirections {
    case Up
    case Down
}

class Player: SKSpriteNode {
    private(set) var isSelected: Bool = false
    private(set) var pullForce: CGFloat = 0
    private var delegate: PlayerMovementDelegate
    
    init(movementDelegate: PlayerMovementDelegate) {
        self.delegate = movementDelegate
        let texture = SKTexture(imageNamed: "Spaceship")
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 25, height: 25) /*texture.size()*/)
        self.zRotation = -CGFloat.pi / 2
        self.isUserInteractionEnabled = true
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5) // Center the anchor
        //self.addGlow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isSelected {
            self.isSelected = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isSelected {
            guard let touch = touches.first else {
                return
            }
            
            let touchLocation: CGPoint = touch.location(in: self.parent!)
            let difference: CGFloat = self.position.y - touchLocation.y
            self.pullForce = abs(difference)
            if self.pullForce > 25 {
                let direction: PlayerMovementDirections = difference > 0 ? .Down : .Up // Is the difference positive or negative
                self.delegate.playerDidMove(player: self, at: direction)
                self.isSelected = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isSelected = false
    }
    
    // TODO Seems not to be working
    //      Put into generic extension
    private func addGlow(radius: Float = 5) {
        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        addChild(effectNode)
        effectNode.addChild(SKSpriteNode(texture: self.texture))
        effectNode.filter = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius":radius])
    }
}

protocol PlayerMovementDelegate {
    func playerDidMove(player: Player, at direction: PlayerMovementDirections)
    func playerCanMove(player: Player, at direction: PlayerMovementDirections) -> Bool
}
