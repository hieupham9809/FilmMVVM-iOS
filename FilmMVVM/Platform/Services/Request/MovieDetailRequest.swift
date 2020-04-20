//
//  MovieDetailRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/15/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

final class MovieDetailRequest : BaseRequest {
    //TODO: create movie request
    required init(id: Int, apiKey : String = Constants.api_key) {
        let body : [String : Any] = [
            "api_key" : apiKey
        ]
        super.init(url: URLs.movieDetailUrl + "/\(String(id))", requestType: .get, body: body)
    }
}
