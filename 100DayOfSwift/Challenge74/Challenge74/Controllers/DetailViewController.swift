//
//  DetailViewController.swift
//  Challenge74
//
//  Created by Евгений Карпов on 08.01.2022.
//

import UIKit

class DetailViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet var textView: UITextView!
  var note: Note!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    let trash = UIBarButtonItem(image: UIImage(systemName: "trash") ?? UIImage(), style: .done, target: self, action: #selector(clearText))
    let shared = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    navigationItem.rightBarButtonItems = [shared, trash]
    textView.text = note.text
    title = note.name
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    note.text = textView.text
    StorageManager.shared.saveData(note: note)
  }
  
  @objc private func clearText() {
    textView.text = ""
  }
  
  @objc func shareTapped() {
    guard let text = textView.text, text != "" else {
      return
    }
    let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
  }
}
