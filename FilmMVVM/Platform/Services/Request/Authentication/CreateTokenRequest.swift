//
//  CreateTokenRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/18/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation

final class CreateTokenRequest : BaseRequest {
    required init(apiKey : String = Constants.api_key) {
        let body : [String: Any] = [
            "api_key" : apiKey
        ]
        super.init(url: URLs.createAuthenToken, requestType: .get, body: body)
    }
}
