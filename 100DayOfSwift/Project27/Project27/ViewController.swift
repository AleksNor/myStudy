//
//  ViewController.swift
//  Project27
//
//  Created by Евгений Карпов on 22.01.2022.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  var currentDrawType = 0
  override func viewDidLoad() {
    super.viewDidLoad()
    
    drawRectangle()
  }
  
  @IBAction func redrawTapped(_ sender: Any) {
    currentDrawType += 1
    
    if currentDrawType > 7 {
      currentDrawType = 0
    }
    
    switch currentDrawType {
    case 0:
      drawRectangle()
    case 1:
      drawCircle()
    case 2:
      drawCheckerboard()
    case 3:
      drawRotatedSquares()
    case 4:
      drawLines()
    case 5:
      drawImagesAndText()
    case 6:
      drawStar()
    case 7:
      drawText()
    default:
      break
    }
  }
  func drawRectangle() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
      
      ctx.cgContext.setFillColor(UIColor.red.cgColor)
      ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
      ctx.cgContext.setLineWidth(10)
      
      ctx.cgContext.addRect(rectangle)
      ctx.cgContext.drawPath(using: .fillStroke)
    }
    imageView.image = img
  }
  
  func drawCircle() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
      
      ctx.cgContext.setFillColor(UIColor.red.cgColor)
      ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
      ctx.cgContext.setLineWidth(10)
      
      ctx.cgContext.addEllipse(in: rectangle)
      ctx.cgContext.drawPath(using: .fillStroke)
    }
    imageView.image = img
  }
  
  func drawCheckerboard() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      ctx.cgContext.setFillColor(UIColor.black.cgColor)
      
      for row in 0 ..< 8 {
        for col in 0 ..< 8 {
          if (row + col) % 2 == 0 {
            ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
          }
        }
      }
    }
    
    imageView.image = img
  }
  
  func drawRotatedSquares() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      ctx.cgContext.translateBy(x: 256, y: 256)
      
      let rotations = 16
      let amount = Double.pi / Double(rotations)
      var rcolor: CGFloat = 0
      var gcolor: CGFloat = 0
      var bcolor: CGFloat = 0
      var check = true
      for _ in 0 ..< rotations {
        ctx.cgContext.rotate(by: CGFloat(amount))
//        ctx.cgContext.setStrokeColor(UIColor(red: rcolor, green: gcolor, blue: bcolor, alpha: 1).cgColor)
//        rcolor += 0.06
//        gcolor += 0.04
//        bcolor += 0.04
        ctx.cgContext.setLineWidth(1)
//        if check {
//          ctx.cgContext.setLineWidth(10)
//          check = false
//        }
        ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
        ctx.cgContext.strokePath()
      }
    }
    
    imageView.image = img
  }
  
  func drawLines() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      ctx.cgContext.translateBy(x: 256, y: 256)
      
      var first = true
      var length: CGFloat = 256
      
      for _ in 0 ..< 256 {
        ctx.cgContext.rotate(by: .pi / 2)
        
        if first {
          ctx.cgContext.move(to: CGPoint(x: length, y: 50))

          first = false
        } else {
          ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))

        }
        
        length *= 0.99
      }
      
      ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
      ctx.cgContext.strokePath()
    }
    
    imageView.image = img
  }
  
  func drawImagesAndText() {
    // 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { ctx in
            // 2
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            // 3
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]

            // 4
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)

            // 5
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)

            // 5
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }

        // 6
        imageView.image = img
  }
  
  func drawStar() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      ctx.cgContext.translateBy(x: 128, y: 128)
      let rectangle = CGRect(x: 0, y: 0, width: 128, height: 128)
      let smallRect = CGRect(x: 0, y: 0, width: 30, height: 30)
      ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
      ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
      ctx.cgContext.setLineWidth(10)
      
      ctx.cgContext.addEllipse(in: rectangle)
      ctx.cgContext.drawPath(using: .fillStroke)
      ctx.cgContext.setFillColor(UIColor.white.cgColor)
      ctx.cgContext.setLineWidth(1)
      ctx.cgContext.translateBy(x: 38, y: 40)
      ctx.cgContext.addEllipse(in: smallRect)
      ctx.cgContext.drawPath(using: .fillStroke)
      ctx.cgContext.translateBy(x: 40, y: 0)
      ctx.cgContext.addEllipse(in: smallRect)
      ctx.cgContext.drawPath(using: .fillStroke)
      ctx.cgContext.translateBy(x: -10, y: 40)
      ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
      ctx.cgContext.setLineWidth(10)
      ctx.cgContext.addEllipse(in: smallRect)
      ctx.cgContext.drawPath(using: .fillStroke)
    }
    imageView.image = img
  }
  
  func drawText() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      let context = ctx.cgContext
      //T
      context.move(to: CGPoint(x: 200, y: 200))
      context.addLine(to: CGPoint(x: 240, y: 200))
      context.move(to: CGPoint(x: 220, y: 200))
      context.addLine(to: CGPoint(x: 220, y: 260))
      context.move(to: CGPoint(x: 250, y: 200))
      //W
      context.addLine(to: CGPoint(x: 265, y: 260))
      context.addLine(to: CGPoint(x: 280, y: 200))
      context.addLine(to: CGPoint(x: 295, y: 260))
      context.addLine(to: CGPoint(x: 310, y: 200))
      context.move(to: CGPoint(x: 320, y: 200))
      context.addLine(to: CGPoint(x: 320, y: 260))
      context.move(to: CGPoint(x: 330, y: 260))
      context.addLine(to: CGPoint(x: 330, y: 200))
      context.addLine(to: CGPoint(x: 370, y: 260))
      context.addLine(to: CGPoint(x: 370, y: 200))
      context.setStrokeColor(UIColor.black.cgColor)
      context.strokePath()
    }
    imageView.image = img
  }
}

