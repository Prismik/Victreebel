//
//  SKNode+Positions.swift
//  chainio
//
//  Created by Francis Beauch on 2017-10-07.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

enum SKPosition {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case center
}

enum SKRelativePosition {
    case leftAlignTop
    case rightAlignTop
    case leftAlignBottom
    case rightAlignBottom
    case underAlignLeft
    case underAlignRight
    case aboveAlignLeft
    case aboveAlignRight
}

extension SKNode {
    var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }

    var width: CGFloat {
        return frame.width
    }

    var height: CGFloat {
        return frame.height
    }

    var minX: CGFloat {
        return frame.minX
    }

    var maxX: CGFloat {
        return frame.maxX
    }

    var minY: CGFloat {
        return frame.minY
    }

    var maxY: CGFloat {
        return frame.maxY
    }

    func setPosition(at relativePosition: SKRelativePosition, margins: UIEdgeInsets, relativeTo node: SKNode) {
        switch relativePosition {
        case .leftAlignTop:
            position = point(for: relativePosition, relativeTo: node) + CGPoint(x: -width - margins.right, y: -height)
        case .rightAlignTop:
            position = point(for: relativePosition, relativeTo: node) + CGPoint(x: margins.left, y: -height)
        case .leftAlignBottom:
            position = point(for: relativePosition, relativeTo: node) + CGPoint(x: -width - margins.right, y: 0)
        case .rightAlignBottom:
            position = point(for: relativePosition, relativeTo: node) + CGPoint(x: margins.left, y: 0)
        case .underAlignLeft:
            position = point(for: relativePosition, relativeTo: node) + CGPoint(x: margins.left, y: -height - margins.top)
        case .underAlignRight:
            position = point(for: relativePosition, relativeTo: node) + CGPoint(x: -width - margins.right, y: -height - margins.top)
        case .aboveAlignLeft:
            position = point(for: relativePosition, relativeTo: node) + CGPoint(x: margins.left, y: margins.bottom)
        case .aboveAlignRight:
            position = point(for: relativePosition, relativeTo: node) + CGPoint(x: -width - margins.right, y: margins.bottom)
        }
    }

    private func point(for relativePosition: SKRelativePosition, relativeTo node: SKNode) -> CGPoint {
        switch relativePosition {
        case .leftAlignTop, .aboveAlignLeft:
            return node.position + CGPoint(x: 0, y: node.height)
        case .rightAlignTop, .aboveAlignRight:
            return node.position + CGPoint(x: node.width, y: node.height)
        case .leftAlignBottom, .underAlignLeft:
            return node.position + CGPoint(x: 0, y: 0)
        case .rightAlignBottom, .underAlignRight:
            return node.position + CGPoint(x: node.width, y: 0)
        }
    }
}

extension SKSpriteNode {
    func anchor(at position: SKPosition) {
        switch position {
        case .topLeft:
            anchorPoint = CGPoint(x: 0, y: 1)
        case.topRight:
            anchorPoint = CGPoint(x: 1, y: 1)
        case .bottomLeft:
            anchorPoint = CGPoint(x: 0, y: 0)
        case .bottomRight:
            anchorPoint = CGPoint(x: 1, y: 0)
        case .center:
            anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
    }
}
