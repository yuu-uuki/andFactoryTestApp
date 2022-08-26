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

public struct ErrorAlert {
  
  static let title = "エラー"
  
  public struct Message {
    static let validationFailed = "処理できませんでした"
    static let serviceUnavailable = "現在このサービスは利用できません"
    static let loadingError = "読み込みに失敗しました"
    static let other = "予期せぬエラーです"
  }
}

public struct Confirm {
  static let title = "確認"
  
  public struct Message {
    static let emptyUser = "ユーザー情報はありません"
  }
}

public struct AlertAction {
  static let ok = "OK"
}
