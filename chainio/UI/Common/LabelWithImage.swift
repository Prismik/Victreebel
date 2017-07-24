//
//  LabelWithImage.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-16.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class LabelWithBackground: SKSpriteNode {
    fileprivate var label: SKLabelNode

    var text: String? {
        didSet {
            label.text = text
        }
    }

    var horizontalAlignmentMode: SKLabelHorizontalAlignmentMode = .center {
        didSet {
            label.horizontalAlignmentMode = horizontalAlignmentMode
        }
    }

    var verticalAlignmentMode: SKLabelVerticalAlignmentMode = .baseline {
        didSet {
            label.verticalAlignmentMode = verticalAlignmentMode
        }
    }

    init(backgroundColor: SKColor, fontName: String, size: CGSize) {
        label = SKLabelNode(fontNamed: fontName)
        super.init(texture: nil, color: backgroundColor, size: size)
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LabelWithImage: LabelWithBackground {
    var image: SKSpriteNode!

    init(texture: SKTexture?, size: CGSize) {
        image = SKSpriteNode(texture: texture, color: .clear, size: texture?.size() ?? CGSize.zero)
        super.init(backgroundColor: .orange, fontName: "HelveticaNeue-Medium", size: size)
        label.position = CGPoint(x: image.width, y: 0)
        addChild(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
