//
//  ViewController.swift
//  Challenge90
//
//  Created by Евгений Карпов on 24.01.2022.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
  @IBOutlet var memeImage: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMems))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
  }
  
  
  @objc func addNewMems() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
    
    if let jpegData = image.jpegData(compressionQuality: 0.8) {
      try? jpegData.write(to: imagePath)
    }
    
    var meme = Meme(image: imageName, topString: "", bottomString: "")
    
    
    dismiss(animated: true)
    createAlert(with: "Add top string") { [weak self] text in
      meme.topString.append(text)
      self?.createAlert(with: "Add bottom string", completion: { text in
        meme.bottomString.append(text)
        self?.drawImage(with: meme)
      })
    }
    
  }
  
  func getDocumentsDirectory() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return path[0]
  }
  
  private func createAlert(with title: String, completion: @escaping ((String) -> Void)) {
    let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    ac.addTextField()
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
      let text = ac.textFields?.first?.text ?? ""
      completion(text)
    }))
    present(ac, animated: true)
  }
  
  func drawImage(with meme: Meme) {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 562))
    
    let img = renderer.image { ctx in
      var rect = CGRect(x: 0, y: 0, width: 512, height: 562)
      ctx.cgContext.setFillColor(UIColor.black.cgColor)
      ctx.cgContext.addRect(rect)
      ctx.cgContext.drawPath(using: .fillStroke)
      
      rect = CGRect(x: 20, y: 120, width: 472, height: 332)
      ctx.cgContext.setFillColor(UIColor.white.cgColor)
      ctx.cgContext.addRect(rect)
      ctx.cgContext.drawPath(using: .fillStroke)
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      
      let attrs: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 36),
        .paragraphStyle: paragraphStyle,
        .foregroundColor: UIColor.white
      ]
      
      let topString = meme.topString
      let bottomString = meme.bottomString
      let topAttributedString = NSAttributedString(string: topString, attributes: attrs)
      let bottomAttributedString = NSAttributedString(string: bottomString, attributes: attrs)
      
      topAttributedString.draw(with: CGRect(x: 10, y: 10, width: 502, height: 100), options: .usesLineFragmentOrigin, context: nil)
      bottomAttributedString.draw(with: CGRect(x: 10, y: 462, width: 502, height: 100), options: .usesLineFragmentOrigin, context: nil)
      
      let path = getDocumentsDirectory().appendingPathComponent(meme.image)
      let image = UIImage(contentsOfFile: path.path)
      image?.draw(in: CGRect(x: 30, y: 130, width: 452, height: 312))
    }
    
    memeImage.image = img
  }
  
  @objc private func shareList() {
    guard let image = memeImage.image?.jpegData(compressionQuality: 0.8) else {
      return
    }
    let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
    present(vc, animated: true)
  }
  
}

