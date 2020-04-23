//
//  UserFavoriteMovieListRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/20/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import Alamofire

final class UserFavoriteMovieListRequest : BaseRequest {
    required init(accountId : Int, apiKey : String = Constants.api_key, sessionId : String, page : Int) {
        let body : [String : Any] = [
            "api_key" : apiKey,
            "session_id" : sessionId,
            "page" : page
        ]
        super.init(url: URLs.getFavoriteMovieList.replacingOccurrences(of: "{id}", with: String(accountId)), requestType: .get, body: body)
    }
}
