//
//  CustomItemList.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-06-10.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import SpriteKit

protocol CustomItemListDelegate {
    func didSelectItem(_ item: DashboardCustomItem)
}

class DashboardCustomItemList: SKSpriteNode {

    var delegate: CustomItemListDelegate?
    
    init(size: CGSize) {
        super.init(texture: nil, color: SKColor.brown, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
