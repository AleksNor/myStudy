//
//  ActionViewController.swift
//  Extension
//
//  Created by Евгений Карпов on 01.01.2022.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
    
    @IBOutlet var script: UITextView!
    
    let defaults = UserDefaults.standard
    var pageTitle = ""
    var pageURL = ""
    var scripts = [String: String]()
    var scriptText = ""
    var scriptTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let done = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(done))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlert))
        navigationItem.rightBarButtonItems = [done]
        navigationItem.leftBarButtonItems = [add]
        
        script.text = scriptText
    }
    
    @IBAction func done() {
        guard let scriptTitle = scriptTitle  else {
            let ac = UIAlertController(title: "Save as", message: nil, preferredStyle: .alert)
            ac.addTextField { textField in
                textField.placeholder = "JS Name"
            }
            ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [unowned self] _ in
                guard let text = ac.textFields?.first?.text, text != "" else {
                    navigationController?.popToRootViewController(animated: true)
                    return
                }
                scripts[text] = script.text ?? ""
                defaults.set(scripts, forKey: pageURL)
                navigationController?.popToRootViewController(animated: true)
            }))
            present(ac, animated: true)
            return
        }
        
        let ac = UIAlertController(title: "Save as", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "JS Name"
            textField.text = scriptTitle
        }
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            [unowned self] _ in
            guard let text = ac.textFields?.first?.text, text != "" else {
                navigationController?.popToRootViewController(animated: true)
                return
            }
            if text == scriptTitle {
                scripts[scriptTitle] = script.text ?? ""
                defaults.set(scripts, forKey: pageURL)
                navigationController?.popToRootViewController(animated: true)
                return
            }
            scripts[text] = script.text ?? ""
            scripts.removeValue(forKey: scriptTitle)
            defaults.set(scripts, forKey: pageURL)
            navigationController?.popToRootViewController(animated: true)
        }))
        present(ac, animated: true)
    }
    
    @objc func addAlert() {
        let ac = UIAlertController(title: "Choose JS code snippet", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Show alert", style: .default, handler: { [weak self] _ in
            self?.script.text = "alert(document.title);"
            self?.done()
        }))
        present(ac, animated: true)
    }
    
}
