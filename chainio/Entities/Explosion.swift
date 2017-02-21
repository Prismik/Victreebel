//
//  Explosion.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-02-17.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class Explosion: SKSpriteNode {
    private static var atlas: SKTextureAtlas? = nil
    private static var textures: [SKTexture] = []
    private static var count: Int = 0
    
    public class func loadTextures() {
        Explosion.atlas = SKTextureAtlas(named: "explosion.atlas")
        for i in 1...Explosion.atlas!.textureNames.count {
            let name = "explosion_\(i).png"
            Explosion.textures.append(SKTexture(imageNamed: name))
        }
    
    }
    
    init(position: CGPoint) {
        let texture = Explosion.textures[0]
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.position = position
        self.detonate()
    }
    
    init(texture: SKTexture!) {
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
    }
    
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func detonate() {
        self.run(SKAction.animate(with: Explosion.textures, timePerFrame: 0.05), completion: {
            self.removeFromParent()
        })
    }
}
