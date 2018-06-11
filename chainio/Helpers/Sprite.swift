//
//  SKSpriteNode+TouchHandler.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-06-10.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class Sprite: SKSpriteNode {
    private var touchUpHandler: (() -> Void)?

    func touchUpInside(handler: @escaping () -> Void) {
        touchUpHandler = handler
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        touchUpHandler?()
    }
}
