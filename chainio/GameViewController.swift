//
//  GameViewController.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-01-20.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = MainMenuScene(size: view.bounds.size)
        
        // Load static textures
        Explosion.loadTextures()
        Enemy.loadTextures()
        Turret.loadTextures()
        
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
