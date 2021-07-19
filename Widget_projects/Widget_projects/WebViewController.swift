//
//  WebViewController.swift
//  Widget_projects
//
//  Created by 소프트웨어컴퓨터 on 2021/06/06.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://google.com"
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        webView.load(request)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
        
    }
    
   
}
