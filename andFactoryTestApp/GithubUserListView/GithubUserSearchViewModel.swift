//
//  GithubUserSearchViewModel.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/23.
//

import Foundation
import RxSwift
import RxCocoa

class GithubUserSearchViewModel {
  
  var items: Observable<Users>?
  private let disposeBag = DisposeBag()
  /// 最初に表示するユーザー
  var users: [User] = [] {
    didSet {
      reloadHandler()
    }
  }
  
  init(searchWord: Observable<String>, model: GithubSearchAPIModel) {
    // 紐付け
    self.items = searchWord
      .filter { $0.count >= 1 }
      .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
      .flatMapLatest({ searchWord in
        return model.searchUser(["q": searchWord, "per_page": "30"])
          .observe(on: MainScheduler.instance)
      })
  }
  
  /// ユーザー一覧取得
  func getUserList() {
    // ユーザー一覧取得
    model.getUserList { users, error in
      if let err = error {
        self.error = err
      } else {
        self.users = users
      }
    }
  }
}
