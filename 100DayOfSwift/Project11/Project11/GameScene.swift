//
//  GameScene.swift
//  Project11
//
//  Created by Евгений Карпов on 10.12.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var editLabel: SKLabelNode!
    var gameOverLabel: SKLabelNode!
    var ballsCountLabel: SKLabelNode!
    var currentLevelLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editingMode: Bool = false {
        didSet{
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    var level = 1 {
        didSet{
            currentLevelLabel.text = "Current level: \(level)"
        }
    }
    
    var ballsCount = 5 {
        didSet {
            ballsCountLabel.text = "Balls: \(ballsCount)"
        }
    }
    
    var ballNodes: [SKSpriteNode] = []
    var boxNodes: [SKSpriteNode] = []
    
    var ballCollors = ["ballGreen", "ballGrey", "ballCyan", "ballBlue", "ballYellow", "ballPurple", "ballRed"]
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        ballsCountLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsCountLabel.text = "Balls: 5"
        ballsCountLabel.horizontalAlignmentMode = .right
        ballsCountLabel.position = CGPoint(x: 300, y: 700)
        ballsCountLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        addChild(ballsCountLabel)
        
        currentLevelLabel = SKLabelNode(fontNamed: "Chalkduster")
        currentLevelLabel.text = "Current Lavel: 1"
        currentLevelLabel.horizontalAlignmentMode = .right
        currentLevelLabel.position = CGPoint(x: 600, y: 700)
        currentLevelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        addChild(currentLevelLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.text = "GAME OVER!!!"
        gameOverLabel.fontSize = 40
        gameOverLabel.position = CGPoint(x: 512, y: 384)
        gameOverLabel.isHidden = true
        gameOverLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        addChild(gameOverLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        generateRandomBox(with: 5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            guard gameOverLabel.isHidden else {
                gameOverLabel.isHidden = true
                return
            }
            
            let location = touch.location(in: self)
            
            let objects = nodes(at: location)
            
            if objects.contains(editLabel) {
                editingMode.toggle()
            } else {
                if editingMode {
                    let size = CGSize(width: Int.random(in: 16...128), height: 16)
                    
                    let box = SKSpriteNode(color: .getRandomColor(), size: size)
                    box.zRotation = CGFloat.random(in: 0...3)
                    box.position = location
                    
                    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                    box.physicsBody?.isDynamic = false
                    box.name = "box"
                    boxNodes.append(box)
                    
                    addChild(box)
                } else {
                    if ballsCount > 0 {
                        guard ballNodes.count != 1 else {
                            return
                        }
                        let ball = SKSpriteNode(imageNamed: ballCollors.randomElement() ?? "ballRed")
                        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
                        ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                        ball.physicsBody?.restitution = 0.4
                        ball.position = CGPoint(x: location.x, y: 768)
                        ball.name = "ball"
                        addChild(ball)
                        ballNodes.append(ball)
                    } else {
                        
                    }
                }
            }
            
        }
    }
    
    private func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width/2)
        bouncer.physicsBody?.isDynamic = false
        bouncer.physicsBody?.restitution = 0.8
        bouncer.zPosition = 100
        addChild(bouncer)
    }
    
    private func makeSlot(at position: CGPoint, isGood: Bool) {
        let slotBase: SKSpriteNode
        let slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
            }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let foreverSpin = SKAction.repeatForever(spin)
        
        slotGlow.run(foreverSpin)
    }
    
    private func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(object: ball, forGood: true)
            ballsCount += 1
            ballNodes = []
        } else if object.name == "bad" {
            destroy(object: ball, forGood: false)
            ballsCount -= 1
            ballNodes = []
            gameOverChecker()
        } else if object.name == "box" {
            score += 1
            boxNodes.remove(at: 0)
            destroy(object: object, forGood: nil)
        }
    }
    
     func destroy(object: SKNode, forGood: Bool?) {
        guard let forGood = forGood else {
            object.removeFromParent()
            levelChecker()
            return
        }

        if forGood {
            if let magicParticles = SKEmitterNode(fileNamed: "MagicParticle") {
                magicParticles.position = object.position
                addChild(magicParticles)
            }
        } else {
            if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
                fireParticles.position = object.position
                addChild(fireParticles)
            }
        }
        
        object.removeFromParent()
    }
        
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
    }
    
    private func generateRandomBox(with count: Int) {
        for _ in 0..<count {
            let size = CGSize(width: Int.random(in: 16...128), height: 16)
            
            let box = SKSpriteNode(color: .getRandomColor(), size: size)
            box.zRotation = CGFloat.random(in: 0...3)
            box.position = CGPoint(x: Int.random(in: 10...1000), y: Int.random(in: 150...650))
            
            box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
            box.physicsBody?.isDynamic = false
            box.name = "box"
            boxNodes.append(box)
            
            addChild(box)
        }
    }
    
    private func levelChecker() {
        guard boxNodes.count == 0 else {
            return
        }
        gameOverLabel.text = "LEVEL \(level) COMPLETE! Your score: \(score)"
        gameOverLabel.isHidden = false
        level += 1
        generateRandomBox(with: (5 * level))
    }
    
    private func startNewgame() {
        score = 0
        level = 1
        ballsCount = 5
        generateRandomBox(with: (5 * level))
    }
    
    private func gameOverChecker(){
        if ballsCount == 0 {
            for box in boxNodes {
                box.removeFromParent()
            }
            boxNodes.removeAll()
            gameOverLabel.text = "GAME OVER! Your score is \(score)"
            gameOverLabel.isHidden = false
            startNewgame()
        }
    }
    
    
}
