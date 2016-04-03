//
//  GameScene.swift
//  SpaceShooter
//
//  Created by ravizza on 4/3/16.
//  Copyright (c) 2016 reliability. All rights reserved.
//

import SpriteKit

var player = SKSpriteNode?()
var enemy = SKSpriteNode?()
var projectile = SKSpriteNode?()
var start = SKSpriteNode?()

var playerSize = CGSize(width: 50, height: 50)
var enemySize = CGSize(width: 40, height: 40)
var projectileSize = CGSize(width: 10, height: 10)
var startSize = CGSize?()

var offBalckColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
var offWhoteColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)



var touchLocation = CGPoint?()

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            touchLocation = touch.locationInNode(self)
            
            }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
