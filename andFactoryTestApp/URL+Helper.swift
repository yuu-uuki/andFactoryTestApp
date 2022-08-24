//
//  URL+Helper.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/24.
//

import Foundation
import UIKit

extension URL {
  /// URL→画像へ変換
  /// - Returns: 画像
  func convertToImage() -> UIImage {
    do {
      let data = try Data(contentsOf: self)
      return UIImage(data: data) ?? UIImage()
    } catch let err {
      print("Error : \(err.localizedDescription)")
    }
    return UIImage()
  }
}
