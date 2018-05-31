//
//  Affinity.swift
//  chainio
//
//  Created by Francis Beauchamp on 2018-05-30.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation

enum Affinity {
    case raw // 1, 1
    case utility // -1, -1
    case reach // 1, -1
    case refined // -1, 1
    case none
}
