//
//  UIAlertHelper.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/24.
//

import Foundation
import UIKit

class UIAlertHelper {
  
  var title = ""
  var message = ""
  
  init(title: String, message: String) {
    self.title = title
    self.message = message
  }
  
  /// 画面に表示
  struct PresentAlert {
    var alert: UIAlertController
    var presentVC: UIViewController
    func show() {
      presentVC.present(alert, animated: true)
    }
  }
  
  /// ボタン1個のアラート作成
  struct SingleSelectAlert {
    var title: String
    var message: String
    var closure: (() -> Void)?
    
    /// アクションを追加
    func make() -> UIAlertController {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: AlertAction.ok, style: .default, handler: { _ in if let closure = closure {
        closure() } }))
      return alert
    }
  }
  
  /// ボタン1個のアラート呼び出し
  func makeSingleAlert(_ viewController: UIViewController, okClosure: (() -> Void)?) -> PresentAlert {
    return PresentAlert(alert: SingleSelectAlert(title: title, message: message, closure: okClosure).make(), presentVC: viewController)
  }
  
}
