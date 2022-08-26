//
//  GithubUserSearchViewModel.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/23.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class GithubUserSearchViewModel {
  
  var searchEvent: Observable<Users>?
  /// 講読解除
  private let disposeBag = DisposeBag()
  private let model = GithubSearchAPIModel()
  /// 最初に表示するユーザー
  var users: [User] = [] {
    didSet {
      reloadHandler()
    }
  }
  /// 検索したユーザー
  var searchUsers: Users? {
    didSet {
      reloadHandler()
    }
  }
  /// エラー情報
  var error: AFError? {
    didSet {
      alertHandler()
    }
  }
  
  // viewの更新処理
  var reloadHandler: () -> Void = { }
  var alertHandler: () -> Void = { }
  
  init(searchWord: Observable<String>) {
    // 紐付け
    self.searchEvent = searchWord
      .filter { $0.count >= 1 }
      .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
      .flatMapLatest({ searchWord in
        // ユーザー検索
        return self.model.searchUser(["q": searchWord])
          .observe(on: MainScheduler.instance)
      })
    
    // ユーザー検索後のハンドリング
    self.searchEvent?.subscribe({ [weak self] event in
      switch event {
      case .next(let users):
        // ユーザー情報セット
        self?.searchUsers = users
      case .error(let error):
        // アラートを表示
        self?.error = error.asAFError
      case .completed:
        break
      }
    })
    .disposed(by: disposeBag)
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
