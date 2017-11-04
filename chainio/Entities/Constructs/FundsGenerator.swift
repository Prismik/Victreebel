//
//  FundGenerator.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

protocol FundsGeneratorDelegate: class {
    func computeFunds() -> Int
}

class FundsGenerator {
    weak var delegate: FundsGeneratorDelegate?

    private let generationDelay: TimeInterval
    private var timer: Timer = Timer()

    init(delay: TimeInterval) {
        self.generationDelay = delay
    }

    deinit {
        timer.invalidate()
    }

    @objc
    private func generate() {
        GameProperties.funds += delegate?.computeFunds() ?? 0
    }

    func enable() {
        timer = Timer.scheduledTimer(timeInterval: generationDelay, target: self, selector: #selector(FundsGenerator.generate), userInfo: nil, repeats: true)
    }
}
