//
//  GameViewController.swift
//  Project29
//
//  Created by Евгений Карпов on 28.01.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  @IBOutlet var angleSlider: UISlider!
  @IBOutlet var angleLabel: UILabel!
  @IBOutlet var velocitySlider: UISlider!
  @IBOutlet var velocityLabel: UILabel!
  @IBOutlet var launchButton: UIButton!
  @IBOutlet var playerNumber: UILabel!
  
  @IBOutlet var onePlayerScore: UILabel!
  @IBOutlet var twoPlayerScore: UILabel!
  
  var oneScore = 0 {
    didSet {
      onePlayerScore.text = "Score: \(oneScore)"
    }
  }
  
  var twoScore = 0 {
    didSet {
      twoPlayerScore.text = "Score: \(twoScore)"
    }
  }
  
  var currentGame: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
              currentGame = scene as? GameScene
              currentGame.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
      
      angleChanged(angleSlider)
      velocityChanged(velocitySlider)
      
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
  
  @IBAction func angleChanged(_ sender: UISlider) {
      angleLabel.text = "Angle: \(Int(angleSlider.value))°"
  }

  @IBAction func velocityChanged(_ sender: UISlider) {
      velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
  }
  
  @IBAction func launch(_ sender: Any) {
      angleSlider.isHidden = true
      angleLabel.isHidden = true

      velocitySlider.isHidden = true
      velocityLabel.isHidden = true

      launchButton.isHidden = true

      currentGame?.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
  }
  
  func activatePlayer(number: Int) {
      if number == 1 {
          playerNumber.text = "<<< PLAYER ONE"
      } else {
          playerNumber.text = "PLAYER TWO >>>"
      }

      angleSlider.isHidden = false
      angleLabel.isHidden = false

      velocitySlider.isHidden = false
      velocityLabel.isHidden = false

      launchButton.isHidden = false
  }
}
