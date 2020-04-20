//
//  UserInfoRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/20/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import Alamofire

final class UserInfoRequest : BaseRequest {
    required init(apiKey:String=Constants.api_key, sessionId:String) {
        let body : [String : Any] = [
            "api_key" : apiKey,
            "session_id" : sessionId
        ]
        super.init(url: URLs.getAccountInfo, requestType: .get, body: body)
    }
}
