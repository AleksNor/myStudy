//
//  GameScene.swift
//  Project26
//
//  Created by Евгений Карпов on 19.01.2022.
//

import CoreMotion
import SpriteKit
import GameplayKit

enum CollisionTypes: UInt32 {
  case player = 1
  case wall = 2
  case star = 4
  case vortex = 8
  case input = 9
  case output = 10
  case finish = 16
}

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  var motionManager: CMMotionManager!
  var player: SKSpriteNode!
  var lastTouchPosition: CGPoint?
  var scoreLabel: SKLabelNode!
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  var isGameOver = false
  var teleportOutputPosition = CGPoint(x: 0, y: 0)
  var currentLevel = 1
  
  override func didMove(to view: SKView) {
    super.didMove(to: view)
    loadLevel()
    createPlayer()
    physicsWorld.gravity = .zero
    motionManager = CMMotionManager()
    motionManager.startAccelerometerUpdates()
    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.text = "Score: 0"
    scoreLabel.horizontalAlignmentMode = .left
    scoreLabel.position = CGPoint(x: 16, y: 16)
    scoreLabel.zPosition = 2
    addChild(scoreLabel)
    physicsWorld.contactDelegate = self
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }
    
    if nodeA == player {
      playerCollided(with: nodeB)
    } else if nodeB == player {
      playerCollided(with: nodeA)
    }
  }
  
  func loadLevel() {
    guard let levelURL = Bundle.main.url(forResource: "level\(currentLevel)", withExtension: "txt"),
          let levelString = try? String(contentsOf: levelURL) else {
            return
          }
    let lines = levelString.components(separatedBy: "\n")
    
    for (row, line) in lines.reversed().enumerated() {
      for (column, letter) in line.enumerated() {
        let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
        switch letter {
        case "x":
          createWall(at: position)
        case "v":
          createVortex(at: position)
        case "s":
          createStar(at: position)
        case "f":
          createFinish(at: position)
        case "i":
          createTeleportInput(at: position)
        case "o":
          createTeleportOutput(at: position)
        case " ":
          continue
        default:
          fatalError("Unknown level letter: \(letter)")
        }
      }
    }
  }
  
  private func createWall(at position: CGPoint) {
    let node = SKSpriteNode(imageNamed: "block")
    node.position = position
    
    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
    node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
    node.physicsBody?.isDynamic = false
    addChild(node)
  }
  
  private func createVortex(at position: CGPoint) {
    let node = SKSpriteNode(imageNamed: "vortex")
    node.name = "vortex"
    node.position = position
    node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
    node.physicsBody?.isDynamic = false
    
    node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
    node.physicsBody?.collisionBitMask = 0
    addChild(node)
  }
  
  private func createStar(at position: CGPoint) {
    let node = SKSpriteNode(imageNamed: "star")
    node.name = "star"
    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
    node.physicsBody?.isDynamic = false
    
    node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
    node.physicsBody?.collisionBitMask = 0
    node.position = position
    addChild(node)
  }
  
  private func createFinish(at position: CGPoint) {
    let node = SKSpriteNode(imageNamed: "finish")
    node.name = "finish"
    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
    node.physicsBody?.isDynamic = false
    
    node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
    node.physicsBody?.collisionBitMask = 0
    node.position = position
    addChild(node)
  }
  
  private func createTeleportInput(at position: CGPoint) {
    let node = SKSpriteNode(imageNamed: "block")
    node.name = "input"
    node.position = position
    
    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
    node.physicsBody?.isDynamic = false
    
    node.physicsBody?.categoryBitMask = CollisionTypes.input.rawValue
    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
    addChild(node)
  }
  
  private func createTeleportOutput(at position: CGPoint) {
    let node = SKSpriteNode(imageNamed: "output")
    node.position = position
    teleportOutputPosition = CGPoint(x: position.x + node.size.width, y: position.y + node.size.height)
    
    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
    node.physicsBody?.isDynamic = false
    
    node.physicsBody?.categoryBitMask = CollisionTypes.output.rawValue
    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
    addChild(node)
  }
  
  private func restartGame() {
    removeAllChildren()
    loadLevel()
    createPlayer()
    physicsWorld.gravity = .zero

    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.text = "Score: \(score)"
    scoreLabel.horizontalAlignmentMode = .left
    scoreLabel.position = CGPoint(x: 16, y: 16)
    scoreLabel.zPosition = 2
    addChild(scoreLabel)
    physicsWorld.contactDelegate = self
  }
  
  func createPlayer() {
    player = SKSpriteNode(imageNamed: "player")
    player.position = CGPoint(x: 96, y: 672)
    player.zPosition = 1
    player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
    player.physicsBody?.allowsRotation = false
    player.physicsBody?.linearDamping = 0.5
    
    player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
    player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue | CollisionTypes.input.rawValue | CollisionTypes.output.rawValue
    player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
    addChild(player)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    lastTouchPosition = location
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    lastTouchPosition = location
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    lastTouchPosition = nil
  }
  
  override func update(_ currentTime: TimeInterval) {
    guard isGameOver == false else { return }
    
#if targetEnvironment(simulator)
    if let currentTouch = lastTouchPosition {
      let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
      physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
    }
#else
    if let accelerometerData = motionManager.accelerometerData {
      physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
    }
#endif
  }
  
  func playerCollided(with node: SKNode) {
    switch node.name {
    case "vortex":
      player.physicsBody?.isDynamic = false
      isGameOver = true
      score -= 1
      
      let move = SKAction.move(to: node.position, duration: 0.25)
      let scale = SKAction.scale(to: 0.0001, duration: 0.25)
      let remove = SKAction.removeFromParent()
      let sequence = SKAction.sequence([move, scale, remove])
      
      player.run(sequence) { [weak self] in
        self?.createPlayer()
        self?.isGameOver = false
      }
    case "star":
      node.removeFromParent()
      score += 1
    case "finish":
      currentLevel += 1
      guard currentLevel < 3 else {
        isGameOver = true
        player.removeFromParent()
        let node = SKLabelNode(fontNamed: "Chalkduster")
        node.fontSize = 32
        node.position = CGPoint(x: 512, y: 384)
        node.text = "GAME OVER"
        addChild(node)
        return
      }
      restartGame()
      return
    case "input":
      let move = SKAction.move(to: teleportOutputPosition, duration: 0)
      player.run(move)
      return
    default:
      return
    }
  }
}
