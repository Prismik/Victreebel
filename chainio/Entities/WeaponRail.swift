//
//  WeaponRail.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-11.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class WeaponRail: SKSpriteNode, PlayerMovementDelegate {
    var activeTurret: Turret?
    var turrets: [Turret] = []
    
    private var energyDisplacer: SKSpriteNode?
    
    init(parent: SKScene) {
        let texture = SKTexture()
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 25, height: parent.size.height))
        self.position = CGPoint(x: self.size.width / 2, y: 0)
        
        let height = self.size.height * 0.8
        var turretPosition: CGFloat = self.size.height * 0.1
        for _ in 0...3 {
            let turret = Turret()
            turret.position = CGPoint(x: self.position.x, y: turretPosition)
            turretPosition += height / 3
            self.turrets.append(turret)
            self.addChild(turret)
        }
        
        self.activeTurret = self.turrets.first
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO Semitransparent showing neonlike effect filling on drag & releasing on playerMove
    func playerDidMove(player: Player, at direction: PlayerMovementDirections) {
        self.energyDisplacer?.removeFromParent()
        if direction == .Up {
            if let turret = self.nextTurret() {
                self.energyDisplacer = SKSpriteNode(texture: SKTexture(), color: SKColor.orange, size: CGSize(width: 25, height: turret.position.y - self.activeTurret!.position.y))
                self.energyDisplacer!.position = self.activeTurret!.position
                self.activeTurret = turret
            }
        }
        else {
            if let turret = self.previousTurret() {
                self.energyDisplacer = SKSpriteNode(texture: SKTexture(), color: SKColor.orange, size: CGSize(width: 25, height: turret.position.y - self.activeTurret!.position.y))
                self.activeTurret = turret
                self.energyDisplacer!.position = self.activeTurret!.position
            }
        }
        
        self.addChild(self.energyDisplacer!)
        let actionMove: SKAction = SKAction.moveTo(y: activeTurret!.position.y, duration: TimeInterval(0.5))
        actionMove.timingMode = SKActionTimingMode.easeInEaseOut
        player.run(actionMove)
    }
    
    func playerCanMove(player: Player, at direction: PlayerMovementDirections) -> Bool {
        if direction == .Up {
            return self.currentIndex() != 3
        }
        else {
            return self.currentIndex() != 0
        }
    }
    
    public func shoot() {
        self.activeTurret?.shoot()
    }

    private func currentIndex() -> Int? {
        if let turret = self.activeTurret, let currentIndex = self.turrets.index(of: turret) {
            return currentIndex
        }
        
        return nil
    }
    
    private func nextTurret() -> Turret? {
        if let index = self.currentIndex() {
            if index + 1 < self.turrets.count {
                return self.turrets[index + 1]
            }
        }
        
        return nil
    }
    
    private func previousTurret() -> Turret? {
        if let index = self.currentIndex() {
            if index - 1 >= 0 {
                return self.turrets[index - 1]
            }
        }
        
        return nil
    }
    
    
}
