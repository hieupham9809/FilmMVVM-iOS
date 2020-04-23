//
//  LogoutRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/22/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
final class LogoutRequest : BaseRequest {
    required init(apiKey : String = Constants.api_key, sessionId : String) {
            let apiHeader = "?api_key=\(apiKey)"
            let body : [String : Any] = [
                "session_id" : sessionId
            ]
            super.init(url: URLs.deleteSession + apiHeader, requestType: .delete, body: body)
    }
}
