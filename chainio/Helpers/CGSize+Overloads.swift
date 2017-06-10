//
//  CGSize+Overloads.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit


public func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

public func - (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width - right.width, height: left.height - right.height)
}
