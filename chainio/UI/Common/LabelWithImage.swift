//
//  LabelWithImage.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-16.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class LabelWithBackground: SKLabelNode {
    override init() {
        super.init()
    }

    var background: SKSpriteNode!
    init(backgroundColor: SKColor, fontName: String, size: CGSize) {
        background = SKSpriteNode(color: backgroundColor, size: size)
        super.init(fontNamed: fontName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LabelWithImage: LabelWithBackground {
    var image: SKSpriteNode!
    override init() {
        super.init()
    }

    init(texture: SKTexture?, size: CGSize) {
        image = SKSpriteNode(texture: texture, color: .clear, size: texture?.size() ?? CGSize.zero)
        image.position = CGPoint(x: -image.width / 2, y: 0)
        super.init(backgroundColor: .orange, fontName: "HelveticaNeue-Medium", size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
