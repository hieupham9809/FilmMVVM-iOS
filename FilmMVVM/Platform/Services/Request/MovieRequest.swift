//
//  MovieRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

final class MovieRequest : BaseRequest {
    //TODO: create movie request
    required init(page: Int, apiKey : String = Constants.api_key) {
        let body : [String : Any] = [
            "page" : page,
            "api_key" : apiKey
        ]
        super.init(url: URLs.movieExploreUrl, requestType: .get, body: body)
    }
}
