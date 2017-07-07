//
//  GameProperties.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation

class GameProperties {
    static var funds: Int = 250
    static var score: Int = 0
    static let baseMultiplier: Int = 1
    
    class func availableConstructs() -> [Construct.Type] {
        return []
    }
}
