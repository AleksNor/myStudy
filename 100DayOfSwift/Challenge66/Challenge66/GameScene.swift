//
//  GameScene.swift
//  Challenge66
//
//  Created by Евгений Карпов on 31.12.2021.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameScore: SKLabelNode!
    var secondsLabel: SKLabelNode!
    var targetTimer: Timer?
    var gameTimer: Timer?
    var currentTimer = 0.85
    
    var bulletsCount = 6
    var secondsRemaining = 60 {
        didSet {
            secondsLabel.text = "Seconds: \(secondsRemaining)"
        }
    }
    var score: Int = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    var isGameOver = false
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.zPosition = -1
        background.blendMode = .replace
        addChild(background)
        
        secondsLabel = SKLabelNode(fontNamed: "Chalkduster")
        secondsLabel.text = "Seconds: 60"
        secondsLabel.position = CGPoint(x: 270, y: 90)
        secondsLabel.horizontalAlignmentMode = .left
        addChild(secondsLabel)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 270, y: 60)
        gameScore.horizontalAlignmentMode = .left
        addChild(gameScore)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        targetTimer = Timer.scheduledTimer(timeInterval: currentTimer, target: self, selector: #selector(addTarget), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeSec), userInfo: nil, repeats: true)
    }
    
    @objc func addTarget() {
        let number = Int.random(in: 1...3)
        switch number {
        case 1:
            let sprite = createTarget(at: 150)
            addChild(sprite)
        case 2:
            let sprite = createTarget(at: 600)
            addChild(sprite)
        case 3:
            let sprite = createTarget(at: 400)
            addChild(sprite)
        default:
            return
        }
    }
    
    func createTarget(at y: CGFloat) -> SKSpriteNode {
        let sprite = SKSpriteNode(imageNamed: "target")
        sprite.position = CGPoint(x: 1200, y: y)
        let random = Int.random(in: 1...2)
        
        switch random {
        case 1:
            sprite.size = CGSize(width: 80, height: 80)
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
            sprite.physicsBody?.categoryBitMask = 1
            sprite.physicsBody?.collisionBitMask = 1
        default:
            sprite.size = CGSize(width: 200, height: 200)
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
            sprite.physicsBody?.categoryBitMask = 2
            sprite.physicsBody?.collisionBitMask = 2
        }
        
        
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        return sprite
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isGameOver else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            guard let sprite = node as? SKSpriteNode else { continue }
            if sprite.size == CGSize(width: 80, height: 80) {
                score += 5
                sprite.removeFromParent()
            } else if sprite.size == CGSize(width: 200, height: 200) {
                score += 1
                sprite.removeFromParent()
            }
        }
    }
    
    @objc func changeSec() {
        guard secondsRemaining > 0 else {
            isGameOver = true
            targetTimer?.invalidate()
            gameTimer?.invalidate()
            gameScore.horizontalAlignmentMode = .center
            gameScore.fontSize = 48
            gameScore.zPosition = 1
            gameScore.position = CGPoint(x: 512, y: 280)
            let gameOver = SKLabelNode(fontNamed: "Chalkduster")
            gameOver.fontSize = 70
            gameOver.text = "GAME OVER"
            gameOver.zPosition = 2
            gameOver.position = CGPoint(x: 512, y: 400)
            addChild(gameOver)
            return
        }
        secondsRemaining -= 1
        targetTimer?.invalidate()
        currentTimer -= 0.005
        targetTimer = Timer.scheduledTimer(timeInterval: currentTimer, target: self, selector: #selector(addTarget), userInfo: nil, repeats: true)
    }
    
}
