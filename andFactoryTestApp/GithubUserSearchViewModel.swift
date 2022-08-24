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
}
