//
//  MarkFavorite.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/21/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import Alamofire

final class MarkFavorite : BaseRequest {
    required init(accountId : Int, apiKey : String = Constants.api_key, sessionId : String, mediaType : String = "movie", mediaId : Int, favorite : Bool) {
        let apiHeader = "?api_key=\(apiKey)&session_id=\(sessionId)"
        let body : [String : Any] = [
            
            "media_type" : mediaType,
            "media_id" : mediaId,
            "favorite" : favorite
        ]
        super.init(url: URLs.markFavorite.replacingOccurrences(of: "{id}", with: String(accountId)) + apiHeader, requestType: .post, body: body)
    }
}
