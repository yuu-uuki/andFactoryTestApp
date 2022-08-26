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
      initTableView()
    }
  }
  
  @IBOutlet weak var searchBar: UISearchBar! {
    didSet {
      searchBar.delegate = self
    }
  }
  /// 講読解除
  private let disposeBag = DisposeBag()
  /// viewModel作成
  private lazy var viewModel = GithubUserSearchViewModel(searchWord: searchBar.rx.text.orEmpty.asObservable())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // ナビゲーションバーの設定
    initNaviBar()
    initViewModel()
    viewModel.getUserList()
  }
}

// MARK: - tableView処理
extension GithubUserListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if viewModel.searchUsers?.items.count ?? 0 > 0 {
      return viewModel.searchUsers?.items.count ?? 0
    } else {
      return viewModel.users.count
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.tableView.bounds.height / 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubUserListTableViewCell.identifier, for: indexPath) as! GithubUserListTableViewCell
    // セルの設定
    if viewModel.searchUsers?.items.count ?? 0 > 0 {
      cell.setUp(user: viewModel.searchUsers?.items[indexPath.row])
    } else {
      cell.setUp(user: viewModel.users[indexPath.row])
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    // キーボードを閉じる
    view.endEditing(true)
    let storyboard = UIStoryboard(name: GithubUserDetailViewController.identifer, bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: GithubUserDetailViewController.identifer) as? GithubUserDetailViewController else {
      return
    }
    if viewModel.searchUsers?.items.count ?? 0 > 0 {
      vc.htmlUrl = viewModel.searchUsers?.items[indexPath.row].htmlUrl
    } else {
      vc.htmlUrl = viewModel.users[indexPath.row].htmlUrl
    }
    self.navigationController?.pushViewController(vc, animated: true)
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
}

// MARK: - 画面初期設定
extension GithubUserListViewController {
  
  func initViewModel() {
    
    viewModel.reloadHandler = { [weak self] in
      self?.tableView.reloadData()
    }
    
    viewModel.alertHandler = { [weak self] in
      let message = self?.viewModel.error?.alertText
      self?.showAlert(message: message)
      // テーブルを空にする
      self?.emptyTable()
    }
  }
  /// ナビゲーションバーの設定
  private func initNaviBar() {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .white
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    navigationItem.title = Titlename.listView
  }
  
  /// テーブルビューの設定
  private func initTableView() {
    // スクロールで検索キーボード閉じる
    tableView.keyboardDismissMode = .onDrag
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(UINib(nibName: GithubUserListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GithubUserListTableViewCell.identifier)
  }
}

// MARK: - UI更新処理
extension GithubUserListViewController {
  /// テーブルの中身を空にする
  func emptyTable() {
    viewModel.searchUsers = nil
    tableView.reloadData()
  }
  
  /// アラートの表示
  func showAlert(message: String?) {
    UIAlertHelper(title: Error.AlertTitle.error, message: message ?? "").makeSingleAlert(self, okClosure: nil).show()
  }
}
