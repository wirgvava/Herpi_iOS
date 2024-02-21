//
//  ContactViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import UIKit
import WebKit

class ContactViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webWrapperView: UIView!
    
    private var webView = {
        let prefs = WKPreferences()
        let pagePrefs = WKWebpagePreferences()
        pagePrefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = pagePrefs
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    //  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
        self.navigationController?.navigationBar.isHidden = true
        AppAnalytics.logEvents(with: .open_contact, paramName: nil, paramData: nil)
    }
    
    //  MARK: - IBActions
    @IBAction func didTapMenu(){
        openSideMenu(on: self)
    }
    
    @IBAction func didTapChat(){
        openChat()
    }
    
    //  MARK: - Methods
    func setWebView(){
        webView.layer.masksToBounds = true
        webView.layer.cornerRadius = 32
        webView.navigationDelegate = self
        
        let myURL = URL(string: Constants.contactUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        view.addSubview(webView)
        
        webView.leftAnchor.constraint(equalTo: self.webWrapperView.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: self.webWrapperView.rightAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: self.webWrapperView.topAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: self.webWrapperView.heightAnchor).isActive = true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let script = """
                    javascript:(() => {
                    document.getElementsByClassName('navbar')[0].style.display='none';
                    })()
                    """
        webView.evaluateJavaScript(script){ [weak self] result,error in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self)
            } else if let result = result {
                if let html = result as? String {
                    webView.loadHTMLString(html, baseURL: nil)
                } else {
                    print("Error result is not string html.")
                }
            }
        }
    }
}
