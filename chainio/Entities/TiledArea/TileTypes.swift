//
//  TileTypes.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-08.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation

struct TileTypes {
    static let none         : UInt32 = 0
    static let all          : UInt32 = UInt32.max
    static let selectable   : UInt32 = 0b1
    static let passable     : UInt32 = 0b10
    static let buildable    : UInt32 = 0b100
}
