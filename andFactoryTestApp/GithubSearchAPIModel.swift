//
//  GithubSearchAPIModel.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/22.
//

import Foundation
import RxSwift
import Alamofire

class GithubSearchAPIModel {
  
  let client = GithubAPIClient()
  /// ユーザー検索
  /// - Parameter parameter: ユーザー名
  /// - Returns: 成功値 or 失敗値
  func searchUser(_ parameter: [String: Any]) -> Observable<Users> {
    return Observable<Users>.create { observer -> Disposable in
      let request = self.client.getRequest(parameter).validate(statusCode: 200..<300).responseDecodable(of: Users.self, decoder: JSONDecoder()) { response in
        switch response.result {
        case .success(let users):
          // 取得成功
          observer.onNext(users)
        case .failure(let error):
          // 取得失敗
          observer.onError(error)
        }
      }
      return Disposables.create { request.cancel() }
    }
  }
}
