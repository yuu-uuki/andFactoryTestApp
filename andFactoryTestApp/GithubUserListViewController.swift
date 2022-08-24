//
//  GithubUserListViewController.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class GithubUserListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableViewSetUp()
    }
  }
  
  @IBOutlet weak var searchBar: UISearchBar! {
    didSet {
      searchBar.delegate = self
    }
  }
  /// ユーザー情報
  private var users: Users?
  /// 講読解除
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // ナビゲーションバーの設定
    naviBarSetUp()
    
    // ViewModelの作成
    let viewModel = GithubUserSearchViewModel(searchWord: searchBar.rx.text.orEmpty.asObservable(), model: GithubSearchAPIModel())
    
    // ViewModelのitemsを監視
    viewModel.items?.subscribe({ [weak self] event in
      switch event {
      case .next(let users):
        // ユーザー情報セット
        self?.users = users
        self?.tableView.reloadData()
      case .error(let error):
        // アラートを表示
        let message = error.asAFError?.alertText
        UIAlertHelper(title: Error.AlertTitle.error, message: message ?? "").makeSingleAlert(self ?? UIViewController(), okClosure: nil).show()
        // テーブルを空にする
        self?.users = nil
        self?.tableView.reloadData()
      case .completed:
        break
      }
    })
    .disposed(by: disposeBag)
  }
}

// MARK: - tableView処理
extension GithubUserListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.users?.items.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.tableView.bounds.height / 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubUserListTableViewCell.identifier, for: indexPath) as! GithubUserListTableViewCell
    // セルの設定
    cell.setUp(user: self.users?.items[indexPath.row])
    return cell
  }
}

// MARK: - 検索バー処理
extension GithubUserListViewController: UISearchBarDelegate {
  /// 検索ボタン押下
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // キーボードを閉じる
    view.endEditing(true)
    if searchBar.inputTextValidate() {
      self.emptyTable()
    }
  }
  
  /// テーブルの中身を空にする
  func emptyTable() {
    self.users = nil
    tableView.reloadData()
  }
}

// MARK: - 画面初期設定
extension GithubUserListViewController {
  /// ナビゲーションバーの設定
  private func naviBarSetUp() {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .white
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    navigationItem.title = Titlename.listView
  }
  
  /// テーブルビューの設定
  private func tableViewSetUp() {
    // スクロールで検索キーボード閉じる
    tableView.keyboardDismissMode = .onDrag
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(UINib(nibName: GithubUserListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GithubUserListTableViewCell.identifier)
  }
}
