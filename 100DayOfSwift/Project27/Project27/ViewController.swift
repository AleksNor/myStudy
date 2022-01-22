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

        if currentDrawType > 5 {
            currentDrawType = 0
        }

        switch currentDrawType {
        case 0:
            drawRectangle()

        case 1:
            drawCircle()

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
          let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)

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
  
}

