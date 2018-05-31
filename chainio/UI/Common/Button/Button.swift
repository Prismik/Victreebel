//
//  Button.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-08-25.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

class Button: SKSpriteNode {
    private enum State {
        case normal
        case selected
        case disabled
    }

    private var action: (() -> Void)?

    private let defaultTexture: SKTexture
    private let disabledTexture: SKTexture
    private let selectedTexture: SKTexture

    private var state: State = .normal {
        willSet(newState) {
            isUserInteractionEnabled = newState != .disabled
        }

        didSet {
            switch state {
            case .normal:
                texture = defaultTexture
            case .disabled:
                texture = disabledTexture
            case .selected:
                texture = selectedTexture
            }
        }
    }

    private let label: SKLabelNode
    var text: String? {
        didSet {
            label.text = text
        }
    }

    init(defaultTexture: SKTexture, disabledTexture: SKTexture, selectedTexture: SKTexture) {
        self.defaultTexture = defaultTexture
        self.disabledTexture = disabledTexture
        self.selectedTexture = selectedTexture
        label = SKLabelNode(text: nil)
        label.horizontalAlignmentMode = .center
        super.init(texture: defaultTexture, color: SKColor.clear, size: defaultTexture.size())

        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAction(action: @escaping () -> Void) {
        self.action = action
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .selected

        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .normal
        self.action?()

        super.touchesEnded(touches, with: event)
    }
}
