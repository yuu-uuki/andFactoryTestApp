//
//  GithubUserListTableViewCell.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/22.
//

import UIKit

class GithubUserListTableViewCell: UITableViewCell {
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var stackView: UIStackView!
  /// セルID
  static let identifier = "GithubUserListTableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // ラベルのサイズ可変処理
    adjustLabel(label: userLabel)
    adjustLabel(label: typeLabel)
  }
  
  func setUp() {
    self.userImage.backgroundColor = .lightGray
    userLabel.text = "user"
    typeLabel.text = "type"
  }
  
  /// 画面の横幅に合わせて文字サイズを調整する
  private func adjustLabel(label: UILabel) {
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
  }
}
