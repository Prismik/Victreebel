//
//  GameProperties.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation

struct GamePropertiesSnapshot {
    let funds: Int
    let score: Int
}

protocol GamePropertiesObserver: class {
    func gamePropertiesDidChange()
}

class GameProperties {

    static var funds: Int = 250 {
        didSet {
            for subscriber in subscribers {
                subscriber.gamePropertiesDidChange()
            }
        }
    }
    static var score: Int = 0 {
        didSet {
            for subscriber in subscribers {
                subscriber.gamePropertiesDidChange()
            }
        }
    }

    static let baseMultiplier: Int = 1

    private static var subscribers: [GamePropertiesObserver] = []

    class func availableConstructs() -> [Construct.Type] {
        return []
    }

    class func subscribe(_ object: GamePropertiesObserver) {
        subscribers.append(object)
    }

    class func unsubscribe(_ object: GamePropertiesObserver) {
        if let index = subscribers.index(where: { $0 === object }) {
            subscribers.remove(at: index)
        }
    }
}
