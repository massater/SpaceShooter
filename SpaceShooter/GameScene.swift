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
var star = SKSpriteNode?()

var playerSize = CGSize(width: 50, height: 50)
var enemySize = CGSize(width: 40, height: 40)
var projectileSize = CGSize(width: 10, height: 10)
var starSize = CGSize?()

var offBalckColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
var offWhiteColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)

var projectileSpeed :Double = 1.0

var touchLocation = CGPoint?()

var enemySpeed : Double = 2.0
var enemySpawnRate : Double = 1.0
var projectileSpawnRate : Double = 0.4

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = offBalckColor
        spawnPlayer()
        timerEnemySpawn()
        timerStarSpawn()
        timerProjectileSpawn()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            touchLocation = touch.locationInNode(self)
            
            }
    }
   
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            touchLocation = touch.locationInNode(self)
            player?.position.y = (touchLocation?.y)!
        }
    }
    
    func spawnPlayer(){
        player = SKSpriteNode(color: offWhiteColor, size: playerSize)
        player?.position = CGPoint(x: CGRectGetMinX(self.frame) + 100, y: CGRectGetMidY(self.frame))
        
        self.addChild(player!)
    }
    
    func spwanEnemy(){
        let randomY = Int(arc4random_uniform(500) + 200)
        enemy = SKSpriteNode(color: offWhiteColor, size: enemySize)
        enemy?.position = CGPoint(x:1200, y: randomY)
        enemyMoveFoward()
        self.addChild(enemy!)

    }
    
    func enemyMoveFoward(){
        let moveFoward = SKAction.moveToX(-100, duration: enemySpeed)
        let destroy = SKAction.removeFromParent()
        
        enemy?.runAction(SKAction.sequence([moveFoward, destroy]))
    }
    
    
    func timerEnemySpawn(){
        let wait = SKAction.waitForDuration(enemySpawnRate)
        let spawn = SKAction.runBlock { 
            self.spwanEnemy()
        }
        let sequence = SKAction.sequence([wait, spawn])
        self.runAction(SKAction.repeatActionForever(sequence))
    }
    
    
    func starMoveFoward(){
        let randomSpeed = Int(arc4random_uniform(3) + 1)
        
        let moveFoward = SKAction.moveToX(-100, duration: Double(randomSpeed))
        let destroy = SKAction.removeFromParent()
        
        star?.runAction(SKAction.sequence([moveFoward, destroy]))
    }

    
    func timerStarSpawn(){
        let wait = SKAction.waitForDuration(0.1)
        let spawn = SKAction.runBlock {
            self.spawnStar()
        }
        let sequence = SKAction.sequence([wait, spawn])
        self.runAction(SKAction.repeatActionForever(sequence))
    }

    
    func spawnStar(){
        let randomWidth = Int(arc4random_uniform(3) + 1)
        let randomHeight = Int(arc4random_uniform(3) + 1)
        
        let randomY = Int(arc4random_uniform(500) + 200)
        
        starSize = CGSize(width: randomWidth, height: randomHeight)
        
        star = SKSpriteNode(color: offWhiteColor, size: starSize!)
        star?.position = CGPoint(x:1200, y: randomY)
        star?.zPosition = -1
        
        starMoveFoward()
        self.addChild(star!)
    }
    
    
    func spawnProjectile(){
        projectile = SKSpriteNode(color: offWhiteColor, size: projectileSize)
        projectile?.position.y = (player?.position.y)!
        projectile?.position.x = (player?.position.x)!
        
        projectileMoveFoward()
        self.addChild(projectile!)
    }

    func projectileMoveFoward(){
        let moveFoward = SKAction.moveToX(1200, duration: projectileSpeed)
        let destroy = SKAction.removeFromParent()
        
        projectile?.runAction(SKAction.sequence([moveFoward, destroy]))
    }

    func timerProjectileSpawn(){
        let wait = SKAction.waitForDuration(projectileSpawnRate)
        let spawn = SKAction.runBlock {
            self.spawnProjectile()
        }
        let sequence = SKAction.sequence([wait, spawn])
        self.runAction(SKAction.repeatActionForever(sequence))
    }

    
    
    func keepPlayerOnScreen(){
        if player?.position.y >= 640{
            player?.position.y = 640
        }
        
        if player?.position.y <= 125{
            player?.position.y = 125
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        keepPlayerOnScreen()
    }
}
