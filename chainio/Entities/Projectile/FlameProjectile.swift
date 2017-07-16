//
//  DotProjectile.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-15.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class FlameProjectile: Projectile {
    private static var atlas: SKTextureAtlas? = nil
    private static var textures: [SKTexture] = []

    public class func loadTextures() {
        FlameProjectile.atlas = SKTextureAtlas(named: "flame.atlas")
        for i in 1...FlameProjectile.atlas!.textureNames.count {
            let name = "flame_\(i).png"
            FlameProjectile.textures.append(SKTexture(imageNamed: name))
        }
    }

    init() {
        let texture = FlameProjectile.textures[0]
        super.init(texture: texture, color: SKColor.clear, size: texture.size())

        zPosition = 998
        run(SKAction.repeatForever(SKAction.animate(with: FlameProjectile.textures, timePerFrame: 0.05)))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func collisionDidOccur() {
        super.collisionDidOccur()
    }
}

