//
//  GithubAPIClient.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/22.
//

import Foundation
import Alamofire

protocol APIClient {
  var url: String { get }
  func getRequest(_ parameter: [String: Any]) -> DataRequest
}

class GithubAPIClient: APIClient {
  /// ユーザー検索URL
  var url = "https://api.github.com/search/users"
  /// Githubに向けてリクエストを実行
  /// - Parameter parameters: 検索する文字列
  /// - Returns: レスポンス
  func getRequest(_ parameter: [String: Any]) -> DataRequest {
    return AF.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil)
  var url = "https://api.github.com/users"
  /// ユーザー一覧取得
  func getUserList() -> DataRequest {
    return AF.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
  }
  
}
