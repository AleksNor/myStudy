//
//  GameScene.swift
//  Project17
//
//  Created by Евгений Карпов on 27.12.2021.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starField: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var gameOver: SKSpriteNode!
    
    var possobeEnemise = ["ball", "hammer", "tv"]
    var gameTimer: Timer?
    var isGmaeOver = false
    var nodeCounter = 0
    var endPosition: CGPoint!
    var startPosition: CGPoint!
    
    var timerInterval: TimeInterval = 1
    
    var score = 0  {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        gameOver = SKSpriteNode(imageNamed: "gameOver")
        gameOver.position = CGPoint(x: 512, y: 384)
        gameOver.zPosition = 1
        
        starField = SKEmitterNode(fileNamed: "starfield")!
        starField.position = CGPoint(x: 1024, y: 384)
        starField.advanceSimulationTime(10)
        addChild(starField)
        starField.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        score = 0
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        gameTimer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        }
    
    @objc func createEnemy() {
        guard let enemy = possobeEnemise.randomElement() else { return }
        guard nodeCounter != 20 else {
            nodeCounter = 0
            timerInterval -= 0.1
            gameTimer?.invalidate()
            gameTimer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            return
        }
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        nodeCounter += 1
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGmaeOver {
            score += 1
        } else {
            gameTimer?.invalidate()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        var location = touch.location(in: self)
        
        
        
        location.y = (location.y - startPosition.y) + endPosition.y
        location.x = (location.x - startPosition.x) + endPosition.x
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 688 {
            location.y = 688
        }
        if location.x < 70 {
            location.x = 70
        } else if location.x > 950{
            location.x = 950
        }
        
        player.position = location
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        
        player.removeFromParent()
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: 512, y: 280)
        isGmaeOver = true
        
        guard !children.contains(gameOver) else { return }
        addChild(gameOver)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isGmaeOver else  {
            isGmaeOver = false
            gameOver.removeFromParent()
            scoreLabel.position = CGPoint(x: 16, y: 16)
            scoreLabel.horizontalAlignmentMode = .left
            score = 0
            addChild(player)
            player.position = CGPoint(x: 100, y: 384)
            timerInterval = 1
            gameTimer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            return
        }
        guard let touch = touches.first else {return}
        startPosition = touch.location(in: self)
        endPosition = player.position
    }
}
