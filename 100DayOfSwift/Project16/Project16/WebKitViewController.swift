//
//  WebKitViewController.swift
//  Project16
//
//  Created by Евгений Карпов on 26.12.2021.
//

import UIKit
import WebKit

class WebKitilViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            webView.load(URLRequest(url: URL(string: "https://yandex.ru")!))
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    
}

