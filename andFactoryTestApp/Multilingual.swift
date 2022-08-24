//
//  Multilingual.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/22.
//

import Foundation

/// 画面タイトル名
public struct Titlename {
  static let listView = "search user"
}

public struct Error {
  
  public struct AlertTitle {
    static let error = "エラー"
  }
  
  public struct Alertmessage {
    static let validationFailed = "処理できませんでした"
    static let serviceUnavailable = "現在このサービスは利用できません"
    static let other = "予期せぬエラーです"
  }
  
  public struct AlertAction {
    static let ok = "OK"
  }
  
}
