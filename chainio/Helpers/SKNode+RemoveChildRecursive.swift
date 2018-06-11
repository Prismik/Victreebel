//
//  SKNode+RemoveChildRecursive.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-06-10.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SpriteKit

extension SKNode {
    func removeAllChildren(recursive: Bool) {
        if recursive {
            for child in children {
                child.removeAllChildren(recursive: true)
                removeAllChildren()
            }
        } else {
            removeAllChildren()
        }
    }
}
