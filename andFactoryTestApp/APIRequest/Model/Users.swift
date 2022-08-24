//
//  Users.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/22.
//

import Foundation

struct Users: Codable {
  let items: [User]
}

struct User: Codable {
  
  let login: String
  let avatarURL: URL
  let htmlUrl: URL
  let type: String
  
  private enum CodingKeys: String, CodingKey {
    case login
    case avatarURL = "avatar_url"
    case htmlUrl = "html_url"
    case type
  }
  
}
