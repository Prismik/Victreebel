//
//  ContentManager.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-15.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation

class ContentManager {
    class func loadTextures() {
        Explosion.loadTextures()
        Enemy.loadTextures()
        FlameProjectile.loadTextures()
    }
}
