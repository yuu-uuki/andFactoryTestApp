//
//  GithubUserListViewController.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/22.
//

import UIKit

class GithubUserListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // ナビゲーションバーの設定
    naviBarSetUp()
    // スクロールで検索キーボード閉じる
    tableView.keyboardDismissMode = .onDrag
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    searchBar.delegate = self
    
    tableView.register(UINib(nibName: GithubUserListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GithubUserListTableViewCell.identifier)
    
  }
}

// MARK: - tableView処理
extension GithubUserListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.tableView.bounds.height / 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: GithubUserListTableViewCell.identifier, for: indexPath) as! GithubUserListTableViewCell
    cell.setUp()
    return cell
  }
  
}

// MARK: - 検索バー処理
extension GithubUserListViewController: UISearchBarDelegate {
  /// 検索ボタン押下
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // キーボードを閉じる
    view.endEditing(true)
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
}
