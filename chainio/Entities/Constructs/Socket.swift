//
//  Socket.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-03-30.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

// Can hold a rune
class Socket: SKSpriteNode {
    private static let texture: SKTexture = SKTexture(imageNamed: "socket")
    private(set) var rune: Rune?
    let central: Bool
    init(central: Bool) {
        self.central = central
        super.init(texture: Socket.texture,color: UIColor.clear, size: Socket.texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func canAttach(rune: Rune) -> Bool {
//        return (central && rune is CoreRune) || !(central && rune is CoreRune)
        if central {
            return rune is CoreRune
        } else {
            return !(rune is CoreRune)
        }
    }
    
    func attach(rune: Rune) {
        if self.rune == nil {
            self.rune = rune
        } else {
            // handle invalid action
        }
    }
}
