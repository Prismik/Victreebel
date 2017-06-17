//
//  Construct.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation

class Construct {
    let price: Int
    let name: String
    init(price: Int, name: String) {
        self.price = price
        self.name = name
    }

    required convenience init() {
        self.init(price: 0, name: "")
    }
}
