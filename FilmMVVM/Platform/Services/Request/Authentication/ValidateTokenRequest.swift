//
//  ValidateTokenRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/18/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
final class ValidateTokenRequest : BaseRequest {
    required init(requestToken : String, username : String, password : String, apiKey : String = Constants.api_key) {
        let header = "?api_key=\(apiKey)"
        let body : [String : Any] = [
            "username" : username,
            "password" : password,
            "request_token" : requestToken
            
        ]
        super.init(url: URLs.validateAuthenToken + header, requestType: .post, body: body)
    }
}
