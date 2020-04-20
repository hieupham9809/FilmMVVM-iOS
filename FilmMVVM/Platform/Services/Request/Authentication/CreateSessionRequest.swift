//
//  CreateSessionRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/18/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation

final class CreateSessionRequest : BaseRequest {
    required init(requestToken : String, apiKey : String = Constants.api_key) {
        let header = "?api_key=\(apiKey)"
        let body : [String : Any] = [
            "request_token" : requestToken
        ]
        super.init(url: URLs.createAuthenSession + header, requestType: .post, body: body)
    }
}
