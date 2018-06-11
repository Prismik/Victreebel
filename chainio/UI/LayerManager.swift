//
//  LayerManager.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-04-08.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class LayerManager {
    static let ui: CGFloat = 9000
    static let foreground: CGFloat = 5000
    static let background: CGFloat = 2000
    
    private(set) static var bottom: CGFloat = LayerManager.background
    private(set) static var top: CGFloat = LayerManager.ui
    
    private static var nodes: [CGFloat] = []
    class func addNode(_ node: SKNode, zPosition: CGFloat) {
        node.zPosition = zPosition
        nodes.append(zPosition)
        updateLayers()
    }
    
    class func removeNode(_ node: SKNode) {
        guard let index = nodes.index(of: node.zPosition) else { return }
        nodes.remove(at: index)
        updateLayers()
    }
    
    private class func updateLayers() {
        LayerManager.bottom = nodes.min() ?? LayerManager.background
        LayerManager.top = nodes.max() ?? LayerManager.ui
    }
}
