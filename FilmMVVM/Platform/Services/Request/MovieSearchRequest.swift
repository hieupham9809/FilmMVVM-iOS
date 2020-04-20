//
//  MovieSearchRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/17/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
final class MovieSearchRequest : BaseRequest {
    required init(keyword : String, page : Int, api_key: String = Constants.api_key){
        let body : [String : Any] = [
            "query" : keyword,
            "page" : page,
            "api_key" : api_key
        ]
        super.init(url: URLs.movieSearchByTitleUrl, requestType: .get, body: body)
    }
}
