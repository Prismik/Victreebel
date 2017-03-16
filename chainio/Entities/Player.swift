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
    public weak var delegate: PlayerMovementDelegate?
    
    init() {
        let texture = SKTexture(imageNamed: "Spaceship")
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 25, height: 25) /*texture.size()*/)
        self.zRotation = -CGFloat.pi / 2
        self.isUserInteractionEnabled = true
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5) // Center the anchor
        self.zPosition = 3
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
            let direction: PlayerMovementDirections = difference > 0 ? .Down : .Up // Is the difference positive or negative
            self.pullForce = abs(difference)
            self.delegate?.playerDidPull(player: self, at: direction)
            if self.pullForce > 25 {
                if self.delegate?.playerCanMove(player: self, at: direction) ?? false { // defaults to false if delegate is nil
                    self.delegate?.playerDidMove(player: self, at: direction)
                }
                
                self.isSelected = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?.playerDidRelease(player: self)
        self.isSelected = false
    }
}

protocol PlayerMovementDelegate: class {
    func playerDidRelease(player: Player)
    func playerDidPull(player: Player, at direction: PlayerMovementDirections)
    func playerDidMove(player: Player, at direction: PlayerMovementDirections)
    func playerCanMove(player: Player, at direction: PlayerMovementDirections) -> Bool
}
