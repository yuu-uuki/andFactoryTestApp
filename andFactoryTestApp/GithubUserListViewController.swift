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
    tableView.keyboardDismissMode = .onDrag
    searchBar.delegate = self
  }
}

extension GithubUserListViewController: UISearchBarDelegate {
  
  /// 検索ボタン押下
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // キーボードを閉じる
    view.endEditing(true)
  }
}

extension GithubUserListViewController {
  /// ナビゲーションバーの設定
  private func naviBarSetUp() {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .white
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    navigationItem.title = Titlename.listView
  }
}

