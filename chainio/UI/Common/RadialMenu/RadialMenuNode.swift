//
//  RadialMenuNode.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-15.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

protocol RadialMenuNodeData {
    var texture: SKTexture { get }
    var action: (() -> Void)? { get }
}

protocol RadialMenuNodeDelegate: class {
    func didSelect(menuNode: RadialMenuNode)
}

class RadialMenuNode: SKCropNode {
    weak var delegate: RadialMenuNodeDelegate?

    private let action: (() -> Void)?
    init(texture: SKTexture, action: (() -> Void)? = nil) {
        self.action = action
        super.init()
        let mask = SKShapeNode(circleOfRadius: 15)
        mask.fillColor = .red
        maskNode = mask
        xScale = 0
        yScale = 0
        zPosition = LayerManager.ui + 1
        isUserInteractionEnabled = true
        let child = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        addChild(child)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animate(towards point: CGPoint, scalingFactor: CGFloat) {
        let actions = SKAction.group([
            SKAction.move(to: point, duration: 0.45),
            SKAction.scaleX(to: scalingFactor, y: scalingFactor, duration: 0.3)
        ])
        actions.timingMode = SKActionTimingMode.easeInEaseOut
        run(actions)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        action?()
        delegate?.didSelect(menuNode: self)
    }
}
