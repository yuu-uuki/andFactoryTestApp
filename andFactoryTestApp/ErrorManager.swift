//
//  AFError+Helper.swift
//  andFactoryTestApp
//
//  Created by 田中裕貴 on 2022/08/24.
//

import Foundation
import Alamofire

extension AFError {
  public var alertText: String {
    switch self.responseCode {
    case 422: return Error.Alertmessage.validationFailed
    case 503: return Error.Alertmessage.serviceUnavailable
    default: return Error.Alertmessage.serviceUnavailable
    }
  }
}
