//
//  RadialMenu.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-07-15.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class RadialMenu: SKSpriteNode {
    var nodes: [RadialMenuNode] = [] {
        didSet {
            removeAllChildren()
            for node in nodes {
                node.delegate = self
                addChild(node)
            }
        }
    }
    private let radius: CGFloat
    private let animationDuration: TimeInterval
    init(radius: CGFloat, animationDuration: TimeInterval) {
        self.radius = radius
        self.animationDuration = animationDuration
        super.init(texture: nil, color: SKColor.clear, size: CGSize.zero)

        zPosition = 99999
        alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        let anglePerItem: CGFloat = 2 * CGFloat.pi / CGFloat(nodes.count)
        for (index, node) in nodes.enumerated() {
            let direction: CGVector = CGVector.fromAngle(anglePerItem * CGFloat(index) + anglePerItem / 2)
            node.animate(towards: CGPoint(x: direction.dx * radius, y: direction.dy * radius), scalingFactor: 1)
        }

        run(SKAction.fadeAlpha(to: 1, duration: animationDuration))
    }

    func close() {
        for node in nodes {
            node.animate(towards: CGPoint.zero, scalingFactor: 0)
        }

        run(SKAction.fadeAlpha(to: 0, duration: animationDuration), completion: {
            self.removeAllChildren()
            self.removeFromParent()
        })
    }
}

extension RadialMenu: RadialMenuNodeDelegate {
    func didSelect(menuNode: RadialMenuNode) {
        close()
    }
}
