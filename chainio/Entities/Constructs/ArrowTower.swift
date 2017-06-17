//
//  ArrowTower.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation

class ArrowTower: Construct {
    private let shooter: ProjectileShooter = ProjectileShooter(delay: 2, range: 150)
    required init() {
        super.init(price: 50, name: "Arrow tower")
    }
}
