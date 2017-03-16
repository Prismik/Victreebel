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
    
    private var energyDisplacer: SKSpriteNode
    private var distanceBetweenTurrets: CGFloat!
    
    init(parent: SKScene) {
        let texture = SKTexture(imageNamed: "weaponRail")
        
        self.energyDisplacer = SKSpriteNode(texture: SKTexture(imageNamed: "laser"), color: SKColor.orange, size: CGSize(width: 5, height: 0))
        self.energyDisplacer.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.energyDisplacer.position.x = 22
        self.energyDisplacer.zPosition = 10
        
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 25, height: parent.size.height))
        self.anchorPoint = CGPoint.zero
        self.position = CGPoint(x: self.size.width / 2, y: 0)
        
        let height = self.size.height * 0.8
        self.distanceBetweenTurrets = height / 3
        var turretPosition: CGFloat = self.size.height * 0.1
        for _ in 0...3 {
            let turret = Turret()
            turret.position = CGPoint(x: self.position.x, y: turretPosition)
            turret.zPosition = 5
            turretPosition += self.distanceBetweenTurrets
            self.turrets.append(turret)
            self.addChild(turret)
        }
        
        self.activeTurret = self.turrets.first
        self.addChild(self.energyDisplacer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playerDidRelease(player: Player) {
        let resize: SKAction = SKAction.resize(toHeight: 0, duration: TimeInterval(0.5))
        resize.timingMode = SKActionTimingMode.easeInEaseOut
        self.energyDisplacer.run(resize)
    }
    
    func playerDidPull(player: Player, at direction: PlayerMovementDirections) {
        self.energyDisplacer.zRotation = direction == .Up ? 0 : CGFloat.pi
        let ratio: CGFloat = player.pullForce / 25
        let displacerHeight = distanceBetweenTurrets * ratio
        self.energyDisplacer.size.height = displacerHeight
    }
    
    // TODO Semitransparent showing neonlike effect filling on drag & releasing on playerMove
    func playerDidMove(player: Player, at direction: PlayerMovementDirections) {
        var turret: Turret? = nil
        turret = direction == .Up ? self.nextTurret() : self.previousTurret()
        if turret != nil {
            self.energyDisplacer.position.y = turret!.position.y
            self.energyDisplacer.zRotation = direction == .Up ? CGFloat.pi : 0
            self.activeTurret = turret
        }
        
        let resize: SKAction = SKAction.resize(toHeight: 0, duration: TimeInterval(0.5))
        resize.timingMode = SKActionTimingMode.easeInEaseOut
        self.energyDisplacer.run(resize)
        
        let move: SKAction = SKAction.moveTo(y: activeTurret!.position.y, duration: TimeInterval(0.5))
        move.timingMode = SKActionTimingMode.easeInEaseOut
        player.run(move)
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
