//
//  ArticleWebController.swift
//  NewsApp
//
//  Created by amartek on 03/02/24.
//

import UIKit
import WebKit

class ArticleWebController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var urlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
}
