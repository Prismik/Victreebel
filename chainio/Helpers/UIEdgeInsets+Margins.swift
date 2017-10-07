//
//  UIEdgeInsets+Margins.swift
//  chainio
//
//  Created by Francis Beauch on 2017-10-07.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

extension UIEdgeInsets {
    static func margins(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
