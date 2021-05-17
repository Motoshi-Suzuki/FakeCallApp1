//
//  PrivacyPolicyViewController.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/05/15.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    
    var webView: WKWebView!
    var xmarkButton: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "https://www.freeprivacypolicy.com/live/9ed9ffd2-b9cf-4429-a46f-e69ae3d6ffee")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
        
        let xmark = UIImage(systemName: "xmark")
        xmarkButton = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(backToFirstVC))
        self.navigationItem.leftBarButtonItem = xmarkButton
    }
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        view = webView
    }
    
    @objc private func backToFirstVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
