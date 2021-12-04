//
//  DetailViewController.swift
//  Project7
//
//  Created by Евгений Карпов on 29.11.2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
            webView = WKWebView()
            view = webView
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <h3 style="text-align: center; color: #224D70;">\(detailItem.title)</h3>
        <p style="text-align: justify">\(detailItem.body)</p>
        <h4 style="text-align: center; color: #224D70;">Signature count: \(detailItem.signatureCount)</h4>
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
    

}
