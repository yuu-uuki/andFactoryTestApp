//
//  UISearchBar+Helper.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/24.
//

import UIKit

extension UISearchBar {
  /// 入力された値数の確認
  /// - Returns: 0だとtrue
  func inputTextValidate() -> Bool {
    guard let text = self.text else {
      return false
    }
    return text.isEmpty
  }
}
