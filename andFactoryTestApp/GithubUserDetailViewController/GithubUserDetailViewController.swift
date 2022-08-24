//
//  GithubUserDetailViewController.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/24.
//

import UIKit
import WebKit
import PKHUD

class GithubUserDetailViewController: UIViewController {
  
  @IBOutlet weak var webView: WKWebView! {
    didSet {
      webView.navigationDelegate = self
    }
  }
  static let identifer = "GithubUserDetailViewController"
  public var htmlUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
      if let url = self.htmlUrl {
        HUD.show(.progress, onView: self.view)
        
        var request = URLRequest(url: url)
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 1
        self.webView.load(request)
      }
    }
}

// MARK: - webView
extension GithubUserDetailViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    guard let url = navigationAction.request.url else {
      return
    }
    print("リクエストURL: \(url)")
    decisionHandler(.allow)
  }
  
  // 読み込み終了
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    print("読み込み終了")
    HUD.hide()
  }
  
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    print("読み込み失敗(読み込み開始時)\(error)")
    // アラートを表示
    UIAlertHelper(title: Error.AlertTitle.error, message: Error.Alertmessage.loadingError).makeSingleAlert(self, okClosure: nil).show()
    HUD.hide()
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    print("読み込み失敗(読み込み途中)\(error)")
    // アラートを表示
    UIAlertHelper(title: Error.AlertTitle.error, message: Error.Alertmessage.loadingError).makeSingleAlert(self, okClosure: nil).show()
    HUD.hide()
  }
}
